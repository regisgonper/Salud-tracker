import 'package:flutter/material.dart';
import '../models/health_record.dart';
import '../utils/health_logic.dart';

class EstadoFisicoScreen extends StatefulWidget {
  final List<HealthRecord> historial;
  final Function(HealthRecord) onAgregarRegistro;

  const EstadoFisicoScreen({
    super.key,
    required this.historial,
    required this.onAgregarRegistro,
  });

  @override
  State<EstadoFisicoScreen> createState() => _EstadoFisicoScreenState();
}

class _EstadoFisicoScreenState extends State<EstadoFisicoScreen> {
  String _actividad = 'media';
  double _dolor = 0;

  double? _indice;
  String? _categoria;
  int? _color;

  void _calcularEstado() {
    final indice = HealthLogic.calcularIndice(_actividad, _dolor);
    final categoria = HealthLogic.categoriaEstado(indice);
    final color = HealthLogic.colorEstado(indice);

    setState(() {
      _indice = indice;
      _categoria = categoria;
      _color = color;
    });

    widget.onAgregarRegistro(HealthRecord(
      type: 'Estado',
      value: indice,
      category: categoria,
      date: DateTime.now(),
    ));
  }

  String get _actividadLabel {
    switch (_actividad) {
      case 'baja': return 'Baja actividad';
      case 'alta': return 'Alta actividad';
      default: return 'Media actividad';
    }
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

            const Text(
              'Estado Físico',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Índice de bienestar físico (0–100)',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nivel de actividad
                    const Text(
                      'Nivel de actividad física',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Botones de selección de actividad
                    Row(
                      children: ['baja', 'media', 'alta'].map((nivel) {
                        final isSelected = _actividad == nivel;
                        final labels = {
                          'baja': 'Baja',
                          'media': 'Media',
                          'alta': 'Alta'
                        };
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                              onTap: () => setState(() => _actividad = nivel),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF2E86C1)
                                      : const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  labels[nivel]!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 28),

                    // Slider de dolor/cansancio
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nivel de cansancio / dolor',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF374151),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${_dolor.toInt()}/10',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E86C1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Sin dolor', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                        Text('Dolor máximo', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFF2E86C1),
                        inactiveTrackColor: const Color(0xFFE5E7EB),
                        thumbColor: const Color(0xFF2E86C1),
                        overlayColor: const Color(0xFF2E86C1).withOpacity(0.1),
                        trackHeight: 6,
                      ),
                      child: Slider(
                        value: _dolor,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        onChanged: (val) => setState(() => _dolor = val),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Botón calcular
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _calcularEstado,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF28B463),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Calcular Estado Físico',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            // Resultado
            if (_indice != null) ...[
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
                        'Índice de Estado Físico',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_indice!.toInt()}',
                        style: TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                          color: Color(_color!),
                        ),
                      ),
                      const Text(
                        'de 100',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
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
                        'Actividad: $_actividadLabel · Dolor: ${_dolor.toInt()}/10',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '✓ Resultado guardado en historial',
                        style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
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
