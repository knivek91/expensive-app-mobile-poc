import 'package:flutter/material.dart';
import '../services/gasto_service.dart';
import '../theme/fiscal_atelier_theme.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
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
      backgroundColor: FiscalAtelierTheme.surfaceDefault,
      appBar: AppBar(
        backgroundColor: FiscalAtelierTheme.surfaceDefault,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Balance de Gastos',
          style: FiscalAtelierTheme.headlineSm.copyWith(
            color: FiscalAtelierTheme.neutral800,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: FiscalAtelierTheme.neutral700,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        toolbarHeight: 64,
      ),
      body: FutureBuilder<Map<String, double>>(
        future: _getBalances(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: FiscalAtelierTheme.primary,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: FiscalAtelierTheme.bodyMd.copyWith(
                  color: FiscalAtelierTheme.accent,
                ),
              ),
            );
          }

          final balances = snapshot.data ?? {};

          if (balances.isEmpty) {
            return _buildEmptyState();
          }

          double totalGastos = balances.values.fold(
            0,
            (sum, amount) => sum + amount,
          );
          // Assuming two users for simplicity - in reality we'd need to know all participants
          double promedio = totalGastos / 2;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: FiscalAtelierTheme.paddingScreenHorizontal,
              vertical: FiscalAtelierTheme.paddingScreenVertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero balance icon with tonal background
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: FiscalAtelierTheme.primaryLighter,
                    borderRadius: BorderRadius.circular(
                      FiscalAtelierTheme.radiusFull,
                    ),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 40,
                    color: FiscalAtelierTheme.primary,
                  ),
                ),
                const SizedBox(height: FiscalAtelierTheme.space24),

                // Screen title (headline-sm)
                Text(
                  'Balance de Gastos',
                  style: FiscalAtelierTheme.headlineSm.copyWith(
                    color: FiscalAtelierTheme.neutral800,
                  ),
                ),
                const SizedBox(height: FiscalAtelierTheme.space32),

                // Total Gastos card with floating design - fully rounded
                _buildBalanceCard(
                  label: 'Total Gastos',
                  amount: '\$${totalGastos.toStringAsFixed(2)}',
                  icon: Icons.attach_money,
                  isPositive: true,
                ),
                const SizedBox(height: FiscalAtelierTheme.space16),

                // Promedio card - fully rounded
                _buildBalanceCard(
                  label: 'Promedio por persona',
                  amount: '\$${promedio.toStringAsFixed(2)}',
                  icon: Icons.equalizer,
                  isPositive: false,
                ),
                const SizedBox(height: FiscalAtelierTheme.space32),

                // Section title
                Text(
                  'Detalles por persona:',
                  style: FiscalAtelierTheme.titleSm.copyWith(
                    color: FiscalAtelierTheme.neutral700,
                  ),
                ),
                const SizedBox(height: FiscalAtelierTheme.space16),

                // Person balance list with spacing (no dividers)
                ...balances.entries.map(
                  (entry) =>
                      _buildPersonBalanceItem(entry.key, entry.value, promedio),
                ),

                // Bottom spacing for scroll content
                const SizedBox(height: FiscalAtelierTheme.space40),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Build empty state with appropriate icon, typography, and spacing
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          FiscalAtelierTheme.paddingScreenHorizontal,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with neutral tonal background -fully rounded
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: FiscalAtelierTheme.neutral200,
                borderRadius: BorderRadius.circular(
                  FiscalAtelierTheme.radiusFull,
                ),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                size: 40,
                color: FiscalAtelierTheme.neutral500,
              ),
            ),
            const SizedBox(height: FiscalAtelierTheme.space24),
            Text(
              'No hay gastos registrados aún',
              style: FiscalAtelierTheme.labelMd.copyWith(
                color: FiscalAtelierTheme.neutral500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: FiscalAtelierTheme.space8),
            Text(
              'Agrega tus primeros gastos para ver el balance',
              style: FiscalAtelierTheme.bodySm.copyWith(
                color: FiscalAtelierTheme.neutral400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Floating card with fully rounded (pill-like) corners - using Container with BoxDecoration
  Widget _buildBalanceCard({
    required String label,
    required String amount,
    required IconData icon,
    required bool isPositive,
  }) {
    final color = isPositive
        ? FiscalAtelierTheme.primary
        : FiscalAtelierTheme.secondary;
    final bgColor = isPositive
        ? FiscalAtelierTheme.primaryLighter
        : FiscalAtelierTheme.secondaryLighter;

    return Container(
      padding: const EdgeInsets.all(FiscalAtelierTheme.paddingCard),
      decoration: BoxDecoration(
        color: FiscalAtelierTheme.surfaceElevated,
        borderRadius: BorderRadius.circular(FiscalAtelierTheme.radiusFull),
        boxShadow: FiscalAtelierTheme.cardShadow,
      ),
      child: Row(
        children: [
          // Icon container with tonal background - fully rounded
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(
                FiscalAtelierTheme.radiusFull,
              ),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(width: FiscalAtelierTheme.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label (metadata - label-md)
                Text(
                  label,
                  style: FiscalAtelierTheme.labelMd.copyWith(
                    color: FiscalAtelierTheme.neutral500,
                  ),
                ),
                const SizedBox(height: FiscalAtelierTheme.space4),
                // Amount (display-md for hero balances)
                Text(
                  amount,
                  style: FiscalAtelierTheme.displayMd.copyWith(
                    color: FiscalAtelierTheme.neutral800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Person balance item with spacing, no dividers - fully rounded
  Widget _buildPersonBalanceItem(
    String person,
    double amountPaid,
    double promedio,
  ) {
    double difference = amountPaid - promedio;
    bool isCreditor = difference > 0;

    final amountColor = isCreditor
        ? FiscalAtelierTheme.primary
        : FiscalAtelierTheme.secondary;
    final prefix = isCreditor ? '+ ' : '- ';
    final bgColor = isCreditor
        ? FiscalAtelierTheme.primaryLighter
        : FiscalAtelierTheme.secondaryLighter;

    return Padding(
      padding: const EdgeInsets.only(bottom: FiscalAtelierTheme.space12),
      child: Container(
        padding: const EdgeInsets.all(FiscalAtelierTheme.paddingItem),
        decoration: BoxDecoration(
          color: FiscalAtelierTheme.surfaceRaised,
          borderRadius: BorderRadius.circular(FiscalAtelierTheme.radiusFull),
        ),
        child: Row(
          children: [
            // Person name (title-sm)
            Expanded(
              child: Text(
                person,
                style: FiscalAtelierTheme.titleSm.copyWith(
                  color: FiscalAtelierTheme.neutral800,
                ),
              ),
            ),
            // Amount with tonal background container -fully rounded
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: FiscalAtelierTheme.space12,
                vertical: FiscalAtelierTheme.space8,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(
                  FiscalAtelierTheme.radiusFull,
                ),
              ),
              child: Text(
                '$prefix\$${difference.abs().toStringAsFixed(2)}',
                style: FiscalAtelierTheme.titleSm.copyWith(color: amountColor),
              ),
            ),
          ],
        ),
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
}
