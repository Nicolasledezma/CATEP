import 'package:flutter/material.dart';

class ComputacionScreen extends StatelessWidget {
  const ComputacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COMPUTACIÓN'),
        backgroundColor: const Color(0xFF0D3B6E),
      ),
      body: const Center(
        child: Text('Pantalla COMPUTACIÓN', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
