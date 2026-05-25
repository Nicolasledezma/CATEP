import 'package:flutter/material.dart';
import 'login_screen.dart';

class LocalidadScreen extends StatelessWidget {
  const LocalidadScreen({super.key});

  static const List<String> _localidades = [
    'TURMERO',
    'VALENCIA',
    'SAN JOAQUÍN',
    'CHIVACOA',
    'CAUCAGUA',
    'ORIENTE',
  ];

  void _onLocalidadTap(BuildContext context, String localidad) {
    if (localidad == 'TURMERO') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seleccionaste $localidad'),
        duration: const Duration(milliseconds: 900),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final crossAxisCount = width >= 900 ? 3 : width >= 360 ? 2 : 1;
            final logoSize = width >= 900 ? 150.0 : width >= 500 ? 130.0 : 95.0;
            final buttonFontSize = width >= 900 ? 16.0 : width >= 500 ? 14.5 : 13.0;
            final buttonHeight = width >= 900 ? 72.0 : width >= 500 ? 60.0 : 52.0;
            final titleFontSize = width >= 900 ? 20.0 : 18.0;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Image.asset(
                      'img/logo_catep.jpg',
                      width: logoSize,
                      height: logoSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                  
                  const SizedBox(height: 6),
                  Text(
                    'Selecciona tu localidad para continuar',
                    style: TextStyle(
                      color: const Color(0xFF475569),
                      fontSize: titleFontSize - 5,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      itemCount: _localidades.length,
                      physics: width >= 900
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        mainAxisExtent: buttonHeight,
                      ),
                      itemBuilder: (context, index) {
                        final localidad = _localidades[index];
                        return ElevatedButton(
                          onPressed: () => _onLocalidadTap(context, localidad),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D3B6E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          ),
                          child: Text(
                            localidad,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: buttonFontSize,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D3B6E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Versión 1.0 | 2026. CATEP TURMERO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
