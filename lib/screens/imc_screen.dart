import 'package:flutter/material.dart';
import '../models/health_record.dart';
import '../utils/health_logic.dart';

class IMCScreen extends StatefulWidget {
  final List<HealthRecord> historial;
  final Function(HealthRecord) onAgregarRegistro;

  const IMCScreen({
    super.key,
    required this.historial,
    required this.onAgregarRegistro,
  });

  @override
  State<IMCScreen> createState() => _IMCScreenState();
}

class _IMCScreenState extends State<IMCScreen> {
  // Controladores para los campos de texto
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  // Estado del resultado
  double? _imc;
  String? _categoria;
  int? _color;
  String? _errorMensaje;

  void _calcularIMC() {
    setState(() {
      _errorMensaje = null;
      _imc = null;
      _categoria = null;
    });

    final pesoStr = _pesoController.text.trim();
    final alturaStr = _alturaController.text.trim();

    // Validación
    if (pesoStr.isEmpty || alturaStr.isEmpty) {
      setState(() => _errorMensaje = 'Por favor ingresa peso y altura.');
      return;
    }

    final peso = double.tryParse(pesoStr);
    final altura = double.tryParse(alturaStr);

    if (peso == null || altura == null || peso <= 0 || altura <= 0) {
      setState(() => _errorMensaje = 'Ingresa valores numéricos válidos.');
      return;
    }

    if (altura > 3.0) {
      setState(() => _errorMensaje = 'La altura debe estar en metros (ej: 1.70)');
      return;
    }

    // Cálculo
    final imc = HealthLogic.calcularIMC(peso, altura);
    final categoria = HealthLogic.categoriaIMC(imc);
    final color = HealthLogic.colorIMC(imc);

    setState(() {
      _imc = imc;
      _categoria = categoria;
      _color = color;
    });

    // Guardar en historial
    widget.onAgregarRegistro(HealthRecord(
      type: 'IMC',
      value: imc,
      category: categoria,
      date: DateTime.now(),
    ));
  }

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            // Título de sección
            const Text(
              'Calculadora de IMC',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Índice de Masa Corporal',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 32),

            // Card de inputs
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Campo peso
                    TextField(
                      controller: _pesoController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Peso (kg)',
                        hintText: 'Ej: 70',
                        prefixIcon: const Icon(Icons.monitor_weight_outlined,
                            color: Color(0xFF2E86C1)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF2E86C1), width: 2),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Campo altura
                    TextField(
                      controller: _alturaController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Altura (m)',
                        hintText: 'Ej: 1.70',
                        prefixIcon: const Icon(Icons.height, color: Color(0xFF2E86C1)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF2E86C1), width: 2),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Mensaje de error
            if (_errorMensaje != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMensaje!,
                        style: const TextStyle(color: Color(0xFFDC2626), fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // Botón calcular
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _calcularIMC,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E86C1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Calcular IMC',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            // Resultado
            if (_imc != null) ...[
              const SizedBox(height: 28),
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Color(_color!).withOpacity(0.4), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Tu IMC',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _imc!.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                          color: Color(_color!),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(_color!).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _categoria!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(_color!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '✓ Resultado guardado en historial',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
