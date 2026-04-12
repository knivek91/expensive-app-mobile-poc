import 'package:flutter/material.dart';
import '../models/gasto.dart';
import '../services/gasto_service.dart';
import 'gasto_crear_screen.dart';
import 'balance_screen.dart';

class GastosListaScreen extends StatefulWidget {
  const GastosListaScreen({Key? key}) : super(key: key);

  @override
  State<GastosListaScreen> createState() => _GastosListaScreenState();
}

class _GastosListaScreenState extends State<GastosListaScreen> {
  final GastoService _gastoService = GastoService();
  late Stream<List<Gasto>> _gastosStream;

  @override
  void initState() {
    super.initState();
    _gastosStream = _gastoService.gastosStream;
  }

  @override
  void dispose() {
    _gastoService.dispose();
    super.dispose();
  }

  void _navigateToCreateExpense() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const GastoCrearScreen()));
    // Refresh is handled by the stream
  }

  void _navigateToBalance() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const BalanceScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos Compartidos'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logo-expensive-app.png',
            width: 32,
            height: 32,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.show_chart),
            onPressed: _navigateToBalance,
            tooltip: 'Ver balance',
          ),
        ],
      ),
      body: StreamBuilder<List<Gasto>>(
        stream: _gastosStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final gastos = snapshot.data!;

          if (gastos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Aún no hay gastos',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _navigateToCreateExpense,
                    child: const Text('Agregar primer gasto'),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: gastos.length,
            separatorBuilder: (_, __) => const Divider(height: 24),
            itemBuilder: (context, index) {
              final gasto = gastos[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              gasto.descripcion,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '\$${(gasto.monto / 100).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Pagado por: ${gasto.pagadoPor}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Fecha: ${_formatDate(gasto.fecha)}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateExpense,
        child: const Icon(Icons.add),
        tooltip: 'Nuevo gasto',
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
