import 'package:flutter/material.dart';
import 'aula1_screen.dart';
import 'asisomos_screen.dart';
import 'aula5_screen.dart';
import 'computacion_screen.dart';
import 'biblioteca_screen.dart';
import 'reunion_screen.dart';

class PlantaAltaScreen extends StatelessWidget {
  const PlantaAltaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width >= 720;
    final menuItems = [
      {'label': 'AULA 1', 'asset': 'img/aula.png'},
      {'label': 'ASI SOMOS', 'asset': 'img/aula.png'},
      {'label': 'AULA 5', 'asset': 'img/aula.png'},
      {'label': 'COMPUTACIÓN', 'asset': 'img/computadora.png'},
      {'label': 'BIBLIOTECA', 'asset': 'img/biblioteca.png'},
      {'label': 'SALA DE REUNIONES', 'asset': 'img/reunon.png'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0D3B6E)),
        title: const Text(
          'Planta Alta',
          style: TextStyle(
            color: Color(0xFF0D3B6E),
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            const Text(
              'Selecciona un sector',
              style: TextStyle(color: Color(0xFF475569), fontSize: 14),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: menuItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 3 : 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: isWide ? 2.3 : 1.35,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return _buildSectionButton(
                    context,
                    label: item['label']!,
                    assetPath: item['asset']!,
                    color: const Color(0xFFDC2626),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionButton(
    BuildContext context, {
    required String label,
    required String assetPath,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        Widget? nextScreen;
        switch (label) {
          case 'AULA 1':
            nextScreen = const FormularioAula1();
            break;
          case 'ASI SOMOS':
            nextScreen = const AsiSomosScreen();
            break;
          case 'AULA 5':
            nextScreen = const Aula5Screen();
            break;
          case 'COMPUTACIÓN':
            nextScreen = const ComputacionScreen();
            break;
          case 'BIBLIOTECA':
            nextScreen = const BibliotecaScreen();
            break;
          case 'SALA DE REUNIONES':
            nextScreen = const ReunionScreen();
            break;
        }

        if (nextScreen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextScreen!),
          );
          return;
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Entrando a $label')));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.94), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 34,
              child: Image.asset(assetPath, fit: BoxFit.contain),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
