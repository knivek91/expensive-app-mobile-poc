import 'package:flutter/material.dart';
import '../models/gasto.dart';
import '../services/gasto_service.dart';

class GastoCrearScreen extends StatefulWidget {
  const GastoCrearScreen({Key? key}) : super(key: key);

  @override
  State<GastoCrearScreen> createState() => _GastoCrearScreenState();
}

class _GastoCrearScreenState extends State<GastoCrearScreen> {
  final _formKey = GlobalKey<FormState>();
  final GastoService _gastoService = GastoService();
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
        final gasto = Gasto(
          descripcion: _descripcionController.text.trim(),
          monto: (double.parse(_montoController.text) * 100).round(),
          fecha: _fechaSeleccionada,
          pagadoPor: _pagadoPorController.text.trim(),
        );

        await _gastoService.agregarGasto(gasto);
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gasto agregado exitosamente')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
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
      appBar: AppBar(title: const Text('Nuevo Gasto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _montoController,
                decoration: const InputDecoration(
                  labelText: 'Monto (\$)',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  if (double.parse(value) <= 0) {
                    return 'El monto debe ser mayor a cero';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pagadoPorController,
                decoration: const InputDecoration(
                  labelText: 'Pagado por',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese quién pagó';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Fecha: ${_fechaSeleccionada.day}/${_fechaSeleccionada.month}/${_fechaSeleccionada.year}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _seleccionarFecha(context),
                    child: const Text('Cambiar fecha'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _guardarGasto,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Text('Guardar Gasto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
