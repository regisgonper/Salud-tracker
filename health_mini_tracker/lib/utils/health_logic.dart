// Lógica de negocio: cálculos de salud
class HealthLogic {
  
  // ──────────────────────────────────────────────
  // CÁLCULO DE IMC
  // ──────────────────────────────────────────────
  
  /// Calcula el IMC dado peso en kg y altura en metros
  static double calcularIMC(double peso, double altura) {
    if (altura <= 0) return 0;
    return peso / (altura * altura);
  }

  /// Devuelve la categoría del IMC
  static String categoriaIMC(double imc) {
    if (imc < 18.5) return 'Bajo peso';
    if (imc < 25.0) return 'Normal';
    return 'Sobrepeso';
  }

  /// Color asociado a la categoría IMC
  static int colorIMC(double imc) {
    if (imc < 18.5) return 0xFF2196F3; // Azul - bajo peso
    if (imc < 25.0) return 0xFF4CAF50; // Verde - normal
    return 0xFFFF9800;                  // Naranja - sobrepeso
  }

  // ──────────────────────────────────────────────
  // CÁLCULO DE ÍNDICE DE ESTADO FÍSICO
  // ──────────────────────────────────────────────

  /// Calcula el índice de estado físico (0-100)
  /// [actividad]: 'baja', 'media', 'alta'
  /// [dolor]: nivel 0-10
  static double calcularIndice(String actividad, double dolor) {
    double base = 100;

    // Ajuste por actividad
    switch (actividad.toLowerCase()) {
      case 'baja':
        base -= 10;
        break;
      case 'alta':
        base += 10;
        break;
      // 'media' no modifica la base
    }

    // Penalización por cansancio/dolor
    base -= (dolor * 5);

    // Limitar entre 0 y 100
    return base.clamp(0, 100);
  }

  /// Devuelve la categoría del estado físico
  static String categoriaEstado(double indice) {
    if (indice >= 75) return 'Óptimo';
    if (indice >= 50) return 'Normal';
    return 'Fatiga';
  }

  /// Color asociado al estado físico
  static int colorEstado(double indice) {
    if (indice >= 75) return 0xFF4CAF50; // Verde - óptimo
    if (indice >= 50) return 0xFFFFEB3B; // Amarillo - normal
    return 0xFFF44336;                    // Rojo - fatiga
  }
}
