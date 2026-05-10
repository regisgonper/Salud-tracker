import 'package:flutter/material.dart';
import '../models/health_record.dart';

class HistorialScreen extends StatelessWidget {
  final List<HealthRecord> historial;
  final VoidCallback onLimpiar;

  const HistorialScreen({
    super.key,
    required this.historial,
    required this.onLimpiar,
  });

  // Icono según el tipo de registro
  IconData _iconoPorTipo(String tipo) {
    return tipo == 'IMC' ? Icons.monitor_weight_outlined : Icons.directions_run;
  }

  // Color del icono según categoría
  Color _colorPorCategoria(String categoria) {
    switch (categoria) {
      case 'Normal':
      case 'Óptimo':
        return const Color(0xFF28B463);
      case 'Bajo peso':
        return const Color(0xFF2196F3);
      case 'Sobrepeso':
      case 'Fatiga':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFFFFEB3B);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Historial',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    Text(
                      '${historial.length} registro${historial.length != 1 ? 's' : ''}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                if (historial.isNotEmpty)
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: const Text('Limpiar historial'),
                          content: const Text(
                              '¿Estás seguro de que quieres borrar todos los registros?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                onLimpiar();
                                Navigator.pop(ctx);
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFFDC2626)),
                              child: const Text('Borrar todo'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete_outline,
                        color: Color(0xFFDC2626), size: 18),
                    label: const Text('Limpiar',
                        style: TextStyle(color: Color(0xFFDC2626))),
                  ),
              ],
            ),
          ),

          // Lista o estado vacío
          Expanded(
            child: historial.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color: const Color(0xFF9CA3AF).withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Sin registros aún',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Calcula tu IMC o Estado Físico\npara ver resultados aquí',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: historial.length,
                    itemBuilder: (context, index) {
                      // Mostrar más recientes primero
                      final record =
                          historial[historial.length - 1 - index];
                      final color = _colorPorCategoria(record.category);

                      return Card(
                        elevation: 0,
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(
                              color: Color(0xFFE5E7EB), width: 1),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _iconoPorTipo(record.type),
                              color: color,
                              size: 22,
                            ),
                          ),
                          title: Text(
                            record.displayValue,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          subtitle: Text(
                            record.formattedDate,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              record.category,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}