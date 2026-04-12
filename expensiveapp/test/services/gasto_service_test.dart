import 'package:flutter_test/flutter_test.dart';
import 'package:expensiveapp/models/gasto.dart';
import 'package:expensiveapp/services/gasto_service.dart';

void main() {
  final DateTime fixedFecha = DateTime(2024, 6, 15);
  final DateTime fixedCreadoEn = DateTime(2024, 6, 15, 10, 0, 0);

  Gasto makeGasto({
    int monto = 1000,
    String descripcion = 'Test',
    String pagadoPor = 'Ana',
    DateTime? fecha,
    DateTime? creadoEn,
  }) {
    return Gasto(
      monto: monto,
      descripcion: descripcion,
      fecha: fecha ?? fixedFecha,
      pagadoPor: pagadoPor,
      creadoEn: creadoEn ?? fixedCreadoEn,
    );
  }

  group('GastoService constructor', () {
    test('initializes with empty gastos list', () {
      final service = GastoService();
      expect(service.obtenerGastos(), isEmpty);
      service.dispose();
    });

    test('emits initial empty list on stream', () async {
      final service = GastoService();
      final emitted = await service.gastosStream.first;
      expect(emitted, isEmpty);
      service.dispose();
    });
  });

  group('GastoService.agregarGasto', () {
    test('adds a single gasto', () async {
      final service = GastoService();
      final gasto = makeGasto();

      await service.agregarGasto(gasto);

      expect(service.obtenerGastos(), hasLength(1));
      expect(service.obtenerGastos().first, equals(gasto));
      service.dispose();
    });

    test('adds multiple gastos', () async {
      final service = GastoService();
      final g1 = makeGasto(monto: 1000, descripcion: 'Primero');
      final g2 = makeGasto(monto: 2000, descripcion: 'Segundo');
      final g3 = makeGasto(monto: 3000, descripcion: 'Tercero');

      await service.agregarGasto(g1);
      await service.agregarGasto(g2);
      await service.agregarGasto(g3);

      expect(service.obtenerGastos(), hasLength(3));
      service.dispose();
    });

    test('emits updated list on stream after adding', () async {
      final service = GastoService();
      final gasto = makeGasto(monto: 5000, descripcion: 'Cena');

      final List<List<Gasto>> emitted = [];
      final sub = service.gastosStream.listen(emitted.add);

      await service.agregarGasto(gasto);
      // Allow event loop to process
      await Future.delayed(Duration.zero);

      expect(emitted, hasLength(greaterThanOrEqualTo(1)));
      expect(emitted.last, hasLength(1));
      expect(emitted.last.first, equals(gasto));

      await sub.cancel();
      service.dispose();
    });

    test('stream emits after each add', () async {
      final service = GastoService();

      final List<int> lengths = [];
      final sub = service.gastosStream.listen((list) => lengths.add(list.length));

      await service.agregarGasto(makeGasto(descripcion: 'Uno'));
      await service.agregarGasto(makeGasto(descripcion: 'Dos'));
      await Future.delayed(Duration.zero);

      // Initial emit (0) + after first add (1) + after second add (2)
      expect(lengths, containsAll([1, 2]));

      await sub.cancel();
      service.dispose();
    });

    test('added gasto is stored in insertion order', () async {
      final service = GastoService();
      final g1 = makeGasto(descripcion: 'Primero');
      final g2 = makeGasto(descripcion: 'Segundo');

      await service.agregarGasto(g1);
      await service.agregarGasto(g2);

      final gastos = service.obtenerGastos();
      expect(gastos[0], equals(g1));
      expect(gastos[1], equals(g2));
      service.dispose();
    });
  });

  group('GastoService.obtenerGastos', () {
    test('returns empty list when no gastos added', () {
      final service = GastoService();
      expect(service.obtenerGastos(), isEmpty);
      service.dispose();
    });

    test('returns unmodifiable list', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto());

      final gastos = service.obtenerGastos();
      expect(() => (gastos as dynamic).add(makeGasto()), throwsUnsupportedError);
      service.dispose();
    });

    test('returned list contains all added gastos', () async {
      final service = GastoService();
      final g1 = makeGasto(descripcion: 'A');
      final g2 = makeGasto(descripcion: 'B');

      await service.agregarGasto(g1);
      await service.agregarGasto(g2);

      final gastos = service.obtenerGastos();
      expect(gastos, contains(g1));
      expect(gastos, contains(g2));
      service.dispose();
    });
  });

  group('GastoService.obtenerTotalGastos', () {
    test('returns 0.0 when no gastos', () {
      final service = GastoService();
      expect(service.obtenerTotalGastos(), 0.0);
      service.dispose();
    });

    test('converts centavos to dollars (divides by 100)', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 1000));

      expect(service.obtenerTotalGastos(), closeTo(10.0, 0.001));
      service.dispose();
    });

    test('sums all montos across multiple gastos', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 1000));
      await service.agregarGasto(makeGasto(monto: 2000));
      await service.agregarGasto(makeGasto(monto: 3000));

      expect(service.obtenerTotalGastos(), closeTo(60.0, 0.001));
      service.dispose();
    });

    test('handles single centavo correctly', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 1));

      expect(service.obtenerTotalGastos(), closeTo(0.01, 0.0001));
      service.dispose();
    });

    test('handles large monto values', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 1000000));

      expect(service.obtenerTotalGastos(), closeTo(10000.0, 0.01));
      service.dispose();
    });

    test('returns 0.0 for a gasto with zero monto', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 0));

      expect(service.obtenerTotalGastos(), 0.0);
      service.dispose();
    });
  });

  group('GastoService.obtenerBalances', () {
    test('returns empty map when no gastos', () {
      final service = GastoService();
      expect(service.obtenerBalances(), isEmpty);
      service.dispose();
    });

    test('returns single entry for single payer', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 5000, pagadoPor: 'Ana'));

      final balances = service.obtenerBalances();
      expect(balances, hasLength(1));
      expect(balances['Ana'], closeTo(50.0, 0.001));
      service.dispose();
    });

    test('sums gastos for same payer', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 1000, pagadoPor: 'Ana'));
      await service.agregarGasto(makeGasto(monto: 2000, pagadoPor: 'Ana'));
      await service.agregarGasto(makeGasto(monto: 3000, pagadoPor: 'Ana'));

      final balances = service.obtenerBalances();
      expect(balances, hasLength(1));
      expect(balances['Ana'], closeTo(60.0, 0.001));
      service.dispose();
    });

    test('groups separately for different payers', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 1000, pagadoPor: 'Ana'));
      await service.agregarGasto(makeGasto(monto: 2000, pagadoPor: 'Luis'));

      final balances = service.obtenerBalances();
      expect(balances, hasLength(2));
      expect(balances['Ana'], closeTo(10.0, 0.001));
      expect(balances['Luis'], closeTo(20.0, 0.001));
      service.dispose();
    });

    test('mixes payments from multiple payers correctly', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 3000, pagadoPor: 'Ana'));
      await service.agregarGasto(makeGasto(monto: 1500, pagadoPor: 'Luis'));
      await service.agregarGasto(makeGasto(monto: 4500, pagadoPor: 'Ana'));
      await service.agregarGasto(makeGasto(monto: 2500, pagadoPor: 'Maria'));

      final balances = service.obtenerBalances();
      expect(balances['Ana'], closeTo(75.0, 0.001));
      expect(balances['Luis'], closeTo(15.0, 0.001));
      expect(balances['Maria'], closeTo(25.0, 0.001));
      service.dispose();
    });

    test('converts centavos to dollars in balance', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 99, pagadoPor: 'X'));

      final balances = service.obtenerBalances();
      expect(balances['X'], closeTo(0.99, 0.001));
      service.dispose();
    });

    test('payer names are case-sensitive', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 1000, pagadoPor: 'Ana'));
      await service.agregarGasto(makeGasto(monto: 1000, pagadoPor: 'ana'));

      final balances = service.obtenerBalances();
      expect(balances, hasLength(2));
      expect(balances['Ana'], closeTo(10.0, 0.001));
      expect(balances['ana'], closeTo(10.0, 0.001));
      service.dispose();
    });
  });

  group('GastoService.gastosStream', () {
    test('gastosStream is a broadcast stream', () {
      final service = GastoService();
      expect(service.gastosStream.isBroadcast, isTrue);
      service.dispose();
    });

    test('multiple listeners can subscribe to gastosStream', () async {
      final service = GastoService();
      final List<List<Gasto>> listener1Events = [];
      final List<List<Gasto>> listener2Events = [];

      final sub1 = service.gastosStream.listen(listener1Events.add);
      final sub2 = service.gastosStream.listen(listener2Events.add);

      await service.agregarGasto(makeGasto());
      await Future.delayed(Duration.zero);

      expect(listener1Events, isNotEmpty);
      expect(listener2Events, isNotEmpty);

      await sub1.cancel();
      await sub2.cancel();
      service.dispose();
    });

    test('emitted list from stream is unmodifiable', () async {
      final service = GastoService();

      List<Gasto>? captured;
      final sub = service.gastosStream.listen((list) => captured = list);

      await service.agregarGasto(makeGasto());
      await Future.delayed(Duration.zero);

      expect(captured, isNotNull);
      expect(() => (captured as dynamic).add(makeGasto()), throwsUnsupportedError);

      await sub.cancel();
      service.dispose();
    });
  });

  group('GastoService.dispose', () {
    test('dispose closes the stream', () async {
      final service = GastoService();
      service.dispose();

      // After dispose, the stream should be closed (done)
      final isDone = await service.gastosStream.isEmpty.timeout(
        const Duration(milliseconds: 100),
        onTimeout: () => true,
      );
      expect(isDone, isTrue);
    });

    test('obtaining gastos list after dispose still works (list is in memory)', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(descripcion: 'Antes de dispose'));
      service.dispose();

      // The in-memory list is unaffected by dispose
      expect(service.obtenerGastos(), hasLength(1));
    });

    test('obtenerTotalGastos after dispose returns correct value', () async {
      final service = GastoService();
      await service.agregarGasto(makeGasto(monto: 2000));
      service.dispose();

      expect(service.obtenerTotalGastos(), closeTo(20.0, 0.001));
    });
  });
}