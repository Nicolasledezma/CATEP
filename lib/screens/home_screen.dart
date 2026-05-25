import 'package:flutter/material.dart';
import 'planta_alta_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    String label;
    switch (index) {
      case 1:
        label = 'Secci�n Reporte a�n no implementada';
        break;
      case 2:
        label = 'Secci�n Perfil a�n no implementada';
        break;
      default:
        label = 'Ya est�s en Inicio';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(label),
        duration: const Duration(milliseconds: 600),
      ),
    );
  }

  void _onPlantaTap(String planta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => planta == 'Planta Alta'
            ? const PlantaAltaScreen()
            : PlantaDetalleScreen(planta: planta),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width >= 720;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hola, nombre de usuario',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D3B6E),
                          ),
                        ),
                        SizedBox(height: 22),
                        Text(
                          'Organiza y completa tus actividades de hoy',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: isWide
                    ? Row(
                        children: [
                          Expanded(
                            child: _buildPlantaCard(
                              'PLANTA ALTA',
                              'img/leer.png',
                              const Color(0xFFDC2626),
                              () => _onPlantaTap('Planta Alta'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildPlantaCard(
                              'PLANTA BAJA',
                              'img/aprendiz.png',
                              const Color(0xFF16A34A),
                              () => _onPlantaTap('Planta Baja'),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildPlantaCard(
                            'PLANTA ALTA',
                            'img/leer.png',
                            const Color(0xFFDC2626),
                            () => _onPlantaTap('Planta Alta'),
                          ),
                          const SizedBox(height: 16),
                          _buildPlantaCard(
                            'PLANTA BAJA',
                            'img/aprendiz.png',
                            const Color(0xFF16A34A),
                            () => _onPlantaTap('Planta Baja'),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0D3B6E),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -1),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem('Inicio', 'img/home.png', 0),
            _buildNavItem('Reporte', 'img/reporte.png', 1),
            _buildNavItem('Usuario', 'img/user.png', 2),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantaCard(
    String title,
    String assetPath,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.9), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.transparent,
                width: 85,
                height: 85,
                alignment: Alignment.center,
                child: Image.asset(assetPath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Revisa las tareas del sector y comienza el registro.',
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, String assetPath, int index) {
    final selected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onNavTap(index),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: selected ? 1 : 0.65,
            child: Image.asset(assetPath, width: 26, height: 26),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selected ? Colors.white : Colors.white70,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class PlantaDetalleScreen extends StatelessWidget {
  final String planta;

  const PlantaDetalleScreen({super.key, required this.planta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planta),
        backgroundColor: const Color(0xFF0D3B6E),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Pantalla de $planta. Aqu� ir� la l�gica de la lista de actividades y acciones del m�dulo.',
            style: const TextStyle(fontSize: 17, color: Color(0xFF334155)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
