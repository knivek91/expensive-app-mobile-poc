import 'package:flutter_test/flutter_test.dart';
import 'package:expensiveapp/models/gasto.dart';

void main() {
  final DateTime fixedFecha = DateTime(2024, 6, 15, 12, 0, 0);
  final DateTime fixedCreadoEn = DateTime(2024, 6, 15, 14, 30, 0);

  group('Gasto constructor', () {
    test('creates instance with all required fields', () {
      final gasto = Gasto(
        monto: 5000,
        descripcion: 'Almuerzo',
        fecha: fixedFecha,
        pagadoPor: 'Ana',
        creadoEn: fixedCreadoEn,
      );

      expect(gasto.monto, 5000);
      expect(gasto.descripcion, 'Almuerzo');
      expect(gasto.fecha, fixedFecha);
      expect(gasto.pagadoPor, 'Ana');
      expect(gasto.creadoEn, fixedCreadoEn);
    });

    test('creadoEn defaults to DateTime.now() when not provided', () {
      final before = DateTime.now();
      final gasto = Gasto(
        monto: 1000,
        descripcion: 'Café',
        fecha: fixedFecha,
        pagadoPor: 'Luis',
      );
      final after = DateTime.now();

      expect(gasto.creadoEn.isAfter(before) || gasto.creadoEn.isAtSameMomentAs(before), isTrue);
      expect(gasto.creadoEn.isBefore(after) || gasto.creadoEn.isAtSameMomentAs(after), isTrue);
    });

    test('accepts monto of zero', () {
      final gasto = Gasto(
        monto: 0,
        descripcion: 'Gratis',
        fecha: fixedFecha,
        pagadoPor: 'Ana',
      );

      expect(gasto.monto, 0);
    });

    test('accepts large monto value', () {
      final gasto = Gasto(
        monto: 10000000,
        descripcion: 'Viaje',
        fecha: fixedFecha,
        pagadoPor: 'Carlos',
      );

      expect(gasto.monto, 10000000);
    });

    test('accepts empty string descripcion', () {
      final gasto = Gasto(
        monto: 100,
        descripcion: '',
        fecha: fixedFecha,
        pagadoPor: 'Ana',
      );

      expect(gasto.descripcion, '');
    });
  });

  group('Gasto.fromJson', () {
    test('creates Gasto from valid JSON map', () {
      final json = {
        'monto': 7500,
        'descripcion': 'Cena',
        'fecha': '2024-06-15T12:00:00.000',
        'pagadoPor': 'Maria',
        'creadoEn': '2024-06-15T14:30:00.000',
      };

      final gasto = Gasto.fromJson(json);

      expect(gasto.monto, 7500);
      expect(gasto.descripcion, 'Cena');
      expect(gasto.fecha, DateTime.parse('2024-06-15T12:00:00.000'));
      expect(gasto.pagadoPor, 'Maria');
      expect(gasto.creadoEn, DateTime.parse('2024-06-15T14:30:00.000'));
    });

    test('parses ISO8601 date strings correctly', () {
      final json = {
        'monto': 1000,
        'descripcion': 'Test',
        'fecha': '2023-01-01T00:00:00.000Z',
        'pagadoPor': 'Bob',
        'creadoEn': '2023-01-01T10:00:00.000Z',
      };

      final gasto = Gasto.fromJson(json);

      expect(gasto.fecha, DateTime.parse('2023-01-01T00:00:00.000Z'));
      expect(gasto.creadoEn, DateTime.parse('2023-01-01T10:00:00.000Z'));
    });

    test('parses monto as int', () {
      final json = {
        'monto': 999,
        'descripcion': 'Bebida',
        'fecha': '2024-03-10T08:00:00.000',
        'pagadoPor': 'Jose',
        'creadoEn': '2024-03-10T09:00:00.000',
      };

      final gasto = Gasto.fromJson(json);

      expect(gasto.monto, isA<int>());
      expect(gasto.monto, 999);
    });

    test('throws if required key is missing', () {
      final json = {
        'descripcion': 'Sin monto',
        'fecha': '2024-06-15T12:00:00.000',
        'pagadoPor': 'Ana',
        'creadoEn': '2024-06-15T14:30:00.000',
      };

      expect(() => Gasto.fromJson(json), throwsA(anything));
    });

    test('throws if fecha is an invalid date string', () {
      final json = {
        'monto': 100,
        'descripcion': 'Test',
        'fecha': 'not-a-date',
        'pagadoPor': 'Ana',
        'creadoEn': '2024-06-15T14:30:00.000',
      };

      expect(() => Gasto.fromJson(json), throwsA(anything));
    });

    test('throws if creadoEn is an invalid date string', () {
      final json = {
        'monto': 100,
        'descripcion': 'Test',
        'fecha': '2024-06-15T12:00:00.000',
        'pagadoPor': 'Ana',
        'creadoEn': 'invalid',
      };

      expect(() => Gasto.fromJson(json), throwsA(anything));
    });
  });

  group('Gasto.toJson', () {
    test('serializes all fields to map', () {
      final gasto = Gasto(
        monto: 3000,
        descripcion: 'Taxi',
        fecha: fixedFecha,
        pagadoPor: 'Pedro',
        creadoEn: fixedCreadoEn,
      );

      final json = gasto.toJson();

      expect(json['monto'], 3000);
      expect(json['descripcion'], 'Taxi');
      expect(json['fecha'], fixedFecha.toIso8601String());
      expect(json['pagadoPor'], 'Pedro');
      expect(json['creadoEn'], fixedCreadoEn.toIso8601String());
    });

    test('toJson and fromJson roundtrip preserves all fields', () {
      final original = Gasto(
        monto: 12345,
        descripcion: 'Supermercado',
        fecha: fixedFecha,
        pagadoPor: 'Laura',
        creadoEn: fixedCreadoEn,
      );

      final json = original.toJson();
      final restored = Gasto.fromJson(json);

      expect(restored, equals(original));
    });

    test('fecha is serialized as ISO8601 string', () {
      final gasto = Gasto(
        monto: 500,
        descripcion: 'Test',
        fecha: DateTime(2024, 12, 31, 23, 59, 59),
        pagadoPor: 'Alicia',
        creadoEn: fixedCreadoEn,
      );

      final json = gasto.toJson();

      expect(json['fecha'], isA<String>());
      expect(json['creadoEn'], isA<String>());
    });

    test('monto in toJson is an int', () {
      final gasto = Gasto(
        monto: 9999,
        descripcion: 'Test',
        fecha: fixedFecha,
        pagadoPor: 'X',
        creadoEn: fixedCreadoEn,
      );

      final json = gasto.toJson();

      expect(json['monto'], isA<int>());
    });
  });

  group('Gasto equality (==)', () {
    test('two instances with same fields are equal', () {
      final g1 = Gasto(
        monto: 2000,
        descripcion: 'Cine',
        fecha: fixedFecha,
        pagadoPor: 'Ana',
        creadoEn: fixedCreadoEn,
      );
      final g2 = Gasto(
        monto: 2000,
        descripcion: 'Cine',
        fecha: fixedFecha,
        pagadoPor: 'Ana',
        creadoEn: fixedCreadoEn,
      );

      expect(g1, equals(g2));
    });

    test('same instance is equal to itself', () {
      final g = Gasto(
        monto: 1000,
        descripcion: 'Test',
        fecha: fixedFecha,
        pagadoPor: 'Ana',
        creadoEn: fixedCreadoEn,
      );

      expect(g, equals(g));
    });

    test('instances differ when monto differs', () {
      final g1 = Gasto(monto: 1000, descripcion: 'Test', fecha: fixedFecha, pagadoPor: 'Ana', creadoEn: fixedCreadoEn);
      final g2 = Gasto(monto: 2000, descripcion: 'Test', fecha: fixedFecha, pagadoPor: 'Ana', creadoEn: fixedCreadoEn);

      expect(g1, isNot(equals(g2)));
    });

    test('instances differ when descripcion differs', () {
      final g1 = Gasto(monto: 1000, descripcion: 'A', fecha: fixedFecha, pagadoPor: 'Ana', creadoEn: fixedCreadoEn);
      final g2 = Gasto(monto: 1000, descripcion: 'B', fecha: fixedFecha, pagadoPor: 'Ana', creadoEn: fixedCreadoEn);

      expect(g1, isNot(equals(g2)));
    });

    test('instances differ when fecha differs', () {
      final g1 = Gasto(monto: 1000, descripcion: 'Test', fecha: DateTime(2024, 1, 1), pagadoPor: 'Ana', creadoEn: fixedCreadoEn);
      final g2 = Gasto(monto: 1000, descripcion: 'Test', fecha: DateTime(2024, 1, 2), pagadoPor: 'Ana', creadoEn: fixedCreadoEn);

      expect(g1, isNot(equals(g2)));
    });

    test('instances differ when pagadoPor differs', () {
      final g1 = Gasto(monto: 1000, descripcion: 'Test', fecha: fixedFecha, pagadoPor: 'Ana', creadoEn: fixedCreadoEn);
      final g2 = Gasto(monto: 1000, descripcion: 'Test', fecha: fixedFecha, pagadoPor: 'Luis', creadoEn: fixedCreadoEn);

      expect(g1, isNot(equals(g2)));
    });

    test('instances differ when creadoEn differs', () {
      final g1 = Gasto(monto: 1000, descripcion: 'Test', fecha: fixedFecha, pagadoPor: 'Ana', creadoEn: DateTime(2024, 1, 1));
      final g2 = Gasto(monto: 1000, descripcion: 'Test', fecha: fixedFecha, pagadoPor: 'Ana', creadoEn: DateTime(2024, 1, 2));

      expect(g1, isNot(equals(g2)));
    });

    test('is not equal to non-Gasto object', () {
      final g = Gasto(monto: 1000, descripcion: 'Test', fecha: fixedFecha, pagadoPor: 'Ana', creadoEn: fixedCreadoEn);

      // ignore: unrelated_type_equality_checks
      expect(g == 'string', isFalse);
    });
  });

  group('Gasto hashCode', () {
    test('equal instances have same hashCode', () {
      final g1 = Gasto(monto: 500, descripcion: 'Pizza', fecha: fixedFecha, pagadoPor: 'Bob', creadoEn: fixedCreadoEn);
      final g2 = Gasto(monto: 500, descripcion: 'Pizza', fecha: fixedFecha, pagadoPor: 'Bob', creadoEn: fixedCreadoEn);

      expect(g1.hashCode, g2.hashCode);
    });

    test('hashCode is consistent across calls', () {
      final g = Gasto(monto: 300, descripcion: 'Bus', fecha: fixedFecha, pagadoPor: 'Ana', creadoEn: fixedCreadoEn);

      expect(g.hashCode, g.hashCode);
    });

    test('instances with different fields generally have different hashCodes', () {
      final g1 = Gasto(monto: 100, descripcion: 'A', fecha: fixedFecha, pagadoPor: 'X', creadoEn: fixedCreadoEn);
      final g2 = Gasto(monto: 200, descripcion: 'B', fecha: fixedFecha, pagadoPor: 'Y', creadoEn: fixedCreadoEn);

      // Not guaranteed, but highly likely for different values
      expect(g1.hashCode, isNot(equals(g2.hashCode)));
    });
  });
}