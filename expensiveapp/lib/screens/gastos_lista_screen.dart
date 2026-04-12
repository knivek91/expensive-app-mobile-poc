import 'package:flutter/material.dart';
import '../models/gasto.dart';
import '../services/gasto_service.dart';
import 'gasto_crear_screen.dart';
import 'balance_screen.dart';
import '../theme/fiscal_atelier_theme.dart';

class GastosListaScreen extends StatefulWidget {
  const GastosListaScreen({super.key});

  @override
  State<GastosListaScreen> createState() => _GastosListaScreenState();
}

class _GastosListaScreenState extends State<GastosListaScreen> {
  late Stream<List<Gasto>> _gastosStream;

  @override
  void initState() {
    super.initState();
    _gastosStream = GastoService.instance.gastosStream;
  }

  @override
  void dispose() {
    // Don't dispose singleton service
    super.dispose();
  }

  void _navigateToCreateExpense() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const GastoCrearScreen()));
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
        title: Text(
          'Gastos Compartidos',
          style: FiscalAtelierTheme.headlineSm.copyWith(
            color: FiscalAtelierTheme.neutral800,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(FiscalAtelierTheme.space8),
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
          // Only show loader if truly waiting AND no data received yet
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // For errors
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Get data - default to empty list if null
          final gastos = snapshot.data ?? <Gasto>[];

          // Show empty state if no data
          if (gastos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 64,
                    color: FiscalAtelierTheme.neutral400,
                  ),
                  const SizedBox(height: FiscalAtelierTheme.space24),
                  Text(
                    'Aún no hay gastos',
                    style: FiscalAtelierTheme.titleMd.copyWith(
                      color: FiscalAtelierTheme.neutral600,
                    ),
                  ),
                  const SizedBox(height: FiscalAtelierTheme.space16),
                  ElevatedButton(
                    onPressed: _navigateToCreateExpense,
                    child: const Text('Agregar primer gasto'),
                  ),
                ],
              ),
            );
          }

          // Show list
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: FiscalAtelierTheme.paddingScreenHorizontal,
              vertical: FiscalAtelierTheme.space16,
            ),
            itemCount: gastos.length,
            itemBuilder: (context, index) {
              final gasto = gastos[index];
              // Floating card with fully rounded corners (pill-like)
              // Uses spacing instead of Divider between items
              return Padding(
                // Spacing between cards - using 16px for cleaner 8px system
                padding: const EdgeInsets.only(
                  bottom: FiscalAtelierTheme.space16,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: FiscalAtelierTheme.surfaceElevated,
                    borderRadius: BorderRadius.circular(
                      FiscalAtelierTheme.radiusLg,
                    ),
                    boxShadow: FiscalAtelierTheme.cardShadow,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      FiscalAtelierTheme.paddingCard,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row with description and amount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                gasto.descripcion,
                                style: FiscalAtelierTheme.titleSm.copyWith(
                                  color: FiscalAtelierTheme.neutral800,
                                ),
                              ),
                            ),
                            const SizedBox(width: FiscalAtelierTheme.space12),
                            // Primary color for positive amounts (titleSm already has w600)
                            Text(
                              '\$${(gasto.monto / 100).toStringAsFixed(2)}',
                              style: FiscalAtelierTheme.titleSm.copyWith(
                                color: FiscalAtelierTheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: FiscalAtelierTheme.space12),
                        // Metadata: label-md (12sp)
                        Text(
                          'Pagado por: ${gasto.pagadoPor}',
                          style: FiscalAtelierTheme.labelMd.copyWith(
                            color: FiscalAtelierTheme.neutral500,
                          ),
                        ),
                        const SizedBox(height: FiscalAtelierTheme.space4),
                        Text(
                          'Fecha: ${_formatDate(gasto.fecha)}',
                          style: FiscalAtelierTheme.labelMd.copyWith(
                            color: FiscalAtelierTheme.neutral500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateExpense,
        tooltip: 'Nuevo gasto',
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
