import 'package:flutter/material.dart';

class Aula5Screen extends StatelessWidget {
  const Aula5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AULA 5'),
        backgroundColor: const Color(0xFF0D3B6E),
      ),
      body: const Center(
        child: Text('Pantalla AULA 5', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
