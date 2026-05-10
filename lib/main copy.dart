import 'package:flutter/material.dart';
import 'models/health_record.dart';
import 'screens/imc_screen.dart';
import 'screens/estado_fisico_screen.dart';
import 'screens/historial_screen.dart';

void main() {
  runApp(const HealthMiniTrackerApp());
}

class HealthMiniTrackerApp extends StatelessWidget {
  const HealthMiniTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Mini Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E86C1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF4F9FF),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Historial compartido en memoria entre todas las pantallas
  final List<HealthRecord> _historial = [];

  void _agregarRegistro(HealthRecord record) {
    setState(() {
      _historial.add(record);
    });
  }

  void _limpiarHistorial() {
    setState(() {
      _historial.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pantallas con acceso al historial compartido
    final screens = [
      IMCScreen(
        historial: _historial,
        onAgregarRegistro: _agregarRegistro,
      ),
      EstadoFisicoScreen(
        historial: _historial,
        onAgregarRegistro: _agregarRegistro,
      ),
      HistorialScreen(
        historial: _historial,
        onLimpiar: _limpiarHistorial,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0xFF2E86C1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.favorite, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            const Text(
              'Health Mini Tracker',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE5E7EB)),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFF2E86C1).withOpacity(0.12),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) =>
            setState(() => _currentIndex = index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.monitor_weight_outlined),
            selectedIcon: const Icon(Icons.monitor_weight,
                color: Color(0xFF2E86C1)),
            label: 'IMC',
          ),
          const NavigationDestination(
            icon: Icon(Icons.directions_run_outlined),
            selectedIcon: Icon(Icons.directions_run,
                color: Color(0xFF2E86C1)),
            label: 'Estado',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('${_historial.length}'),
              isLabelVisible: _historial.isNotEmpty,
              child: const Icon(Icons.history),
            ),
            selectedIcon: const Icon(Icons.history, color: Color(0xFF2E86C1)),
            label: 'Historial',
          ),
        ],
      ),
    );
  }
}
