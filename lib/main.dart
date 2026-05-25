//main.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/localidad_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // inicialización de supabase
  await Supabase.initialize(
    url: 'https://ioncuphboadistbspbgy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlvbmN1cGhib2FkaXN0YnNwYmd5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM2MDgwODUsImV4cCI6MjA4OTE4NDA4NX0.lJKcfiwsHR6-Dn0iWgQpjbD8ZjaSCKhqKRjjz7QtZ_o',
  );

  runApp(const CatepApp());
}

class CatepApp extends StatelessWidget {
  const CatepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF0D3B6E),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const LocalidadScreen(),
    );
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'TU_SUPABASE_URL',
    anonKey: 'TU_SUPABASE_ANON_KEY',
  );

  runApp(const MyApp());
}