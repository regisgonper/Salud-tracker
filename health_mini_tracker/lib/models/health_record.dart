// Modelo de datos para el historial
class HealthRecord {
  final String type; // 'IMC' o 'Estado'
  final double value;
  final String category;
  final DateTime date;

  HealthRecord({
    required this.type,
    required this.value,
    required this.category,
    required this.date,
  });

  // Convierte el registro a texto para mostrar en la lista
  String get displayValue {
    if (type == 'IMC') {
      return 'IMC: ${value.toStringAsFixed(2)}';
    } else {
      return 'Índice: ${value.toStringAsFixed(0)}/100';
    }
  }

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
