import 'package:flutter/material.dart';
import '../models/gasto.dart';
import '../services/gasto_service.dart';
import '../theme/fiscal_atelier_theme.dart';

class GastoCrearScreen extends StatefulWidget {
  const GastoCrearScreen({Key? key}) : super(key: key);

  @override
  State<GastoCrearScreen> createState() => _GastoCrearScreenState();
}

class _GastoCrearScreenState extends State<GastoCrearScreen> {
  final _formKey = GlobalKey<FormState>();
  final GastoService _gastoService = GastoService.instance;
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _pagadoPorController = TextEditingController();
  DateTime _fechaSeleccionada = DateTime.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _descripcionController.dispose();
    _montoController.dispose();
    _pagadoPorController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _fechaSeleccionada) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  Future<void> _guardarGasto() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final monto = double.parse(_montoController.text);
        if (monto <= 0) {
          throw const FormatException('El monto debe ser mayor a cero');
        }

        final gasto = Gasto(
          descripcion: _descripcionController.text.trim(),
          monto: (monto * 100).round(),
          fecha: _fechaSeleccionada,
          pagadoPor: _pagadoPorController.text.trim(),
        );

        await _gastoService.agregarGasto(gasto);
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Gasto agregado',
                style: FiscalAtelierTheme.bodyMd.copyWith(color: Colors.white),
              ),
              backgroundColor: FiscalAtelierTheme.primary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  FiscalAtelierTheme.radiusMd,
                ),
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error: ${e.toString()}',
                style: FiscalAtelierTheme.bodyMd.copyWith(color: Colors.white),
              ),
              backgroundColor: FiscalAtelierTheme.secondary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  FiscalAtelierTheme.radiusMd,
                ),
              ),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuevo Gasto',
          style: FiscalAtelierTheme.headlineSm.copyWith(
            color: FiscalAtelierTheme.neutral800,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: FiscalAtelierTheme.paddingScreenHorizontal,
          vertical: FiscalAtelierTheme.paddingScreenVertical,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Descripción field - Filled style with background shift on focus
              Text(
                'Descripción',
                style: FiscalAtelierTheme.labelMd.copyWith(
                  color: FiscalAtelierTheme.neutral600,
                ),
              ),
              const SizedBox(height: FiscalAtelierTheme.space8),
              _buildTextField(
                controller: _descripcionController,
                hintText: '¿Qué gastaste?',
                style: FiscalAtelierTheme.bodyMd.copyWith(
                  color: FiscalAtelierTheme.neutral800,
                ),
                hintStyle: FiscalAtelierTheme.bodyMd.copyWith(
                  color: FiscalAtelierTheme.neutral400,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa una descripción';
                  }
                  return null;
                },
              ),

              const SizedBox(height: FiscalAtelierTheme.space24),

              // Monto field - Large editorial style with primary tonal background
              Text(
                'Monto',
                style: FiscalAtelierTheme.labelMd.copyWith(
                  color: FiscalAtelierTheme.neutral600,
                ),
              ),
              const SizedBox(height: FiscalAtelierTheme.space8),
              _buildTextField(
                controller: _montoController,
                hintText: '0.00',
                style: FiscalAtelierTheme.titleLg.copyWith(
                  color: FiscalAtelierTheme.neutral800,
                  fontWeight: FontWeight.w500,
                ),
                hintStyle: FiscalAtelierTheme.titleLg.copyWith(
                  color: FiscalAtelierTheme.neutral400,
                  fontWeight: FontWeight.w500,
                ),
                prefixText: '\$ ',
                prefixStyle: FiscalAtelierTheme.titleLg.copyWith(
                  color: FiscalAtelierTheme.neutral500,
                  fontWeight: FontWeight.w500,
                ),
                isMonto: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa un monto';
                  }
                  final parsed = double.tryParse(value);
                  if (parsed == null) {
                    return 'Ingresa un número válido';
                  }
                  if (parsed <= 0) {
                    return 'El monto debe ser mayor a cero';
                  }
                  return null;
                },
              ),

              const SizedBox(height: FiscalAtelierTheme.space24),

              // Pagado por field - Dropdown with two options
              Text(
                'Pagado por',
                style: FiscalAtelierTheme.labelMd.copyWith(
                  color: FiscalAtelierTheme.neutral600,
                ),
              ),
              const SizedBox(height: FiscalAtelierTheme.space8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: FiscalAtelierTheme.space16,
                ),
                decoration: BoxDecoration(
                  color: FiscalAtelierTheme.surfaceSubtle,
                  borderRadius: BorderRadius.circular(
                    FiscalAtelierTheme.radiusMd,
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  value: _pagadoPorController.text.isEmpty
                      ? null
                      : _pagadoPorController.text,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  hint: Text(
                    'Selecciona quién pagó',
                    style: FiscalAtelierTheme.bodyMd.copyWith(
                      color: FiscalAtelierTheme.neutral400,
                    ),
                  ),
                  style: FiscalAtelierTheme.bodyMd.copyWith(
                    color: FiscalAtelierTheme.neutral800,
                  ),
                  dropdownColor: FiscalAtelierTheme.surfaceElevated,
                  items: const [
                    DropdownMenuItem(value: 'Sienna', child: Text('Sienna')),
                    DropdownMenuItem(value: 'Robert', child: Text('Robert')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      _pagadoPorController.text = value;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Selecciona quién pagó';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: FiscalAtelierTheme.space24),

              // Fecha selector - Tonal section with background separation
              Container(
                padding: const EdgeInsets.all(FiscalAtelierTheme.space16),
                decoration: BoxDecoration(
                  color: FiscalAtelierTheme.surfaceRaised,
                  borderRadius: BorderRadius.circular(
                    FiscalAtelierTheme.radiusMd,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fecha',
                            style: FiscalAtelierTheme.labelMd.copyWith(
                              color: FiscalAtelierTheme.neutral500,
                            ),
                          ),
                          const SizedBox(height: FiscalAtelierTheme.space4),
                          Text(
                            '${_fechaSeleccionada.day}/${_fechaSeleccionada.month}/${_fechaSeleccionada.year}',
                            style: FiscalAtelierTheme.bodyMd.copyWith(
                              color: FiscalAtelierTheme.neutral800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: _isLoading
                          ? null
                          : () => _seleccionarFecha(context),
                      style: TextButton.styleFrom(
                        foregroundColor: FiscalAtelierTheme.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: FiscalAtelierTheme.space16,
                          vertical: FiscalAtelierTheme.space12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            FiscalAtelierTheme.radiusMd,
                          ),
                        ),
                      ),
                      child: Text(
                        'Cambiar',
                        style: FiscalAtelierTheme.titleSm.copyWith(
                          color: FiscalAtelierTheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: FiscalAtelierTheme.space32),

              // Primary button - FilledButton with primary color (#0a8d6a)
              _buildPrimaryButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a text field with focus state using background shift (not border)
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextStyle style,
    required TextStyle hintStyle,
    String? prefixText,
    TextStyle? prefixStyle,
    bool isMonto = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Focus(
      onFocusChange: (hasFocus) {
        // Trigger rebuild to update focus state
        setState(() {});
      },
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;

          return TextFormField(
            controller: controller,
            style: style,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle,
              prefixText: prefixText,
              prefixStyle: prefixStyle,
              filled: true,
              // Use background shift on focus instead of border
              fillColor: isMonto
                  ? (isFocused
                        ? FiscalAtelierTheme.primaryLighter.withValues(
                            alpha: 0.4,
                          )
                        : FiscalAtelierTheme.primaryLighter.withValues(
                            alpha: 0.2,
                          ))
                  : (isFocused
                        ? FiscalAtelierTheme.surfaceMuted
                        : FiscalAtelierTheme.surfaceSubtle),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  FiscalAtelierTheme.radiusMd,
                ),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  FiscalAtelierTheme.radiusMd,
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  FiscalAtelierTheme.radiusMd,
                ),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: FiscalAtelierTheme.space20,
                vertical: isMonto
                    ? FiscalAtelierTheme.space20
                    : FiscalAtelierTheme.space16,
              ),
            ),
            validator: validator,
          );
        },
      ),
    );
  }

  /// Builds primary button with loading state following design system
  Widget _buildPrimaryButton() {
    return FilledButton(
      onPressed: _isLoading ? null : _guardarGasto,
      style: FilledButton.styleFrom(
        backgroundColor: FiscalAtelierTheme.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: FiscalAtelierTheme.neutral300,
        disabledForegroundColor: FiscalAtelierTheme.neutral500,
        padding: const EdgeInsets.symmetric(
          horizontal: FiscalAtelierTheme.space24,
          vertical: FiscalAtelierTheme.space16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FiscalAtelierTheme.radiusMd),
        ),
        elevation: 0,
      ),
      child: _isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            )
          : Text(
              'Guardar Gasto',
              style: FiscalAtelierTheme.titleSm.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}
