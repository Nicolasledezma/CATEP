import 'package:flutter/material.dart';

class BibliotecaScreen extends StatelessWidget {
  const BibliotecaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BIBLIOTECA'),
        backgroundColor: const Color(0xFF0D3B6E),
      ),
      body: const Center(
        child: Text('Pantalla BIBLIOTECA', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
