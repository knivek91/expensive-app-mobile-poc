import 'package:flutter/foundation.dart';

class Gasto {
  final int monto; // En centavos
  final String descripcion;
  final DateTime fecha;
  final String pagadoPor;
  final DateTime creadoEn;

  Gasto({
    required this.monto,
    required this.descripcion,
    required this.fecha,
    required this.pagadoPor,
    DateTime? creadoEn,
  }) : creadoEn = creadoEn ?? DateTime.now();

  factory Gasto.fromJson(Map<String, dynamic> json) {
    return Gasto(
      monto: json['monto'] as int,
      descripcion: json['descripcion'] as String,
      fecha: DateTime.parse(json['fecha'] as String),
      pagadoPor: json['pagadoPor'] as String,
      creadoEn: DateTime.parse(json['creadoEn'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monto': monto,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
      'pagadoPor': pagadoPor,
      'creadoEn': creadoEn.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Gasto &&
          runtimeType == other.runtimeType &&
          monto == other.monto &&
          descripcion == other.descripcion &&
          fecha == other.fecha &&
          pagadoPor == other.pagadoPor &&
          creadoEn == other.creadoEn;

  @override
  int get hashCode =>
      monto.hashCode ^
      descripcion.hashCode ^
      fecha.hashCode ^
      pagadoPor.hashCode ^
      creadoEn.hashCode;
}
