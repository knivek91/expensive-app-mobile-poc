import 'dart:async';
import '../models/gasto.dart';

class GastoService {
  static GastoService? _instance;

  final List<Gasto> _gastos = [];
  late final StreamController<List<Gasto>> _gastosController =
      StreamController<List<Gasto>>.broadcast(
        onListen: () {
          // Emit current state when a listener subscribes
          _gastosController.add(List.unmodifiable(_gastos));
        },
      );

  Stream<List<Gasto>> get gastosStream => _gastosController.stream;

  factory GastoService() {
    return instance;
  }

  GastoService._internal();

  static GastoService get instance {
    _instance ??= GastoService._internal();
    return _instance!;
  }

  Future<void> agregarGasto(Gasto gasto) async {
    _gastos.add(gasto);
    _gastosController.add(List.unmodifiable(_gastos));
  }

  List<Gasto> obtenerGastos() {
    return List.unmodifiable(_gastos);
  }

  double obtenerTotalGastos() {
    return _gastos.fold(0, (sum, gasto) => sum + gasto.monto) / 100.0;
  }

  Map<String, double> obtenerBalances() {
    final Map<String, double> balances = {};
    for (final gasto in _gastos) {
      balances[gasto.pagadoPor] =
          (balances[gasto.pagadoPor] ?? 0) + gasto.monto / 100.0;
    }
    return balances;
  }

  void dispose() {
    _gastosController.close();
    _instance = null; // Reset singleton so future calls create fresh service
  }
}
