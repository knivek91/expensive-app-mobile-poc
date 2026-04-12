import 'package:flutter/material.dart';
import '../services/gasto_service.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final GastoService _gastoService = GastoService();
  late Stream<List<dynamic>> _gastosStream;

  @override
  void initState() {
    super.initState();
    // We can't directly listen to GastosService's stream from here without creating a circular dependency
    // Instead, we'll create a new instance just for reading data in this screen
    // Note: In a production app, we'd use a proper state management solution like Provider or Bloc
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance de Gastos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<Map<String, double>>(
        future: _getBalances(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final balances = snapshot.data ?? {};

          if (balances.isEmpty) {
            return const Center(
              child: Text(
                'No hay gastos registrados aún',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          double totalGastos = balances.values.fold(
            0,
            (sum, amount) => sum + amount,
          );
          // Assuming two users for simplicity - in reality we'd need to know all participants
          double promedio = totalGastos / 2;

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Icon(Icons.show_chart, size: 64, color: Colors.blue),
              const SizedBox(height: 24),
              const Text(
                'Balance de Gastos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              _buildBalanceInfo(
                'Total Gastos',
                '\$${totalGastos.toStringAsFixed(2)}',
                Icons.attach_money,
                Colors.green,
              ),
              const SizedBox(height: 16),
              _buildBalanceInfo(
                'Promedio por persona',
                '\$${promedio.toStringAsFixed(2)}',
                Icons.equalizer,
                Colors.blue,
              ),
              const SizedBox(height: 24),
              const Text(
                'Detalles por persona:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...balances.entries
                  .map(
                    (entry) =>
                        _buildPersonBalance(entry.key, entry.value, promedio),
                  )
                  .toList(),
            ],
          );
        },
      ),
    );
  }

  Future<Map<String, double>> _getBalances() async {
    // Create a temporary service instance to get the data
    final tempService = GastoService();
    try {
      return tempService.obtenerBalances();
    } finally {
      tempService.dispose();
    }
  }

  Widget _buildBalanceInfo(
    String label,
    String amount,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonBalance(
    String person,
    double amountPaid,
    double promedio,
  ) {
    double difference = amountPaid - promedio;
    bool isCreditor = difference > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(person, style: const TextStyle(fontSize: 16))),
          Text(
            '${isCreditor ? '+ ' : '- '}\$${difference.abs().toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isCreditor ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
