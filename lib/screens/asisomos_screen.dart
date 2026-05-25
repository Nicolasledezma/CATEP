import 'package:flutter/material.dart';

class AsiSomosScreen extends StatelessWidget {
  const AsiSomosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASÍ SOMOS'),
        backgroundColor: const Color(0xFF0D3B6E),
      ),
      body: const Center(
        child: Text('Pantalla ASÍ SOMOS', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
