import 'package:flutter/material.dart';

class ReunionScreen extends StatelessWidget {
  const ReunionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SALA DE REUNIONES'),
        backgroundColor: const Color(0xFF0D3B6E),
      ),
      body: const Center(
        child: Text('Pantalla SALA DE REUNIONES', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
