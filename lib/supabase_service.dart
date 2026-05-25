import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _supabase = Supabase.instance.client;


  Future<bool> subirYRegistrarReporte({
    required File archivoPdf,
    required String nombreReporte,
    required String usuarioId,
  }) async {
    try {
      final extension = archivoPdf.path.split('.').last;
      final filePath = 'usuarios/$usuarioId/${DateTime.now().millisecondsSinceEpoch}.$extension';

      await _supabase.storage.from('documentos').upload(filePath, archivoPdf);

      await _supabase.from('reportes').insert({
        'nombre_reporte': nombreReporte,
        'archivo_path': filePath,
        'usuario_id': usuarioId,
      });

      return true;
    } catch (e) {
      print('Error al subir/registrar el reporte: $e');
      return false;
    }
  }

  Future<String?> obtenerUrlDescarga(String archivoPath) async {
    try {
      
      final String signedUrl = await _supabase.storage
          .from('documentos')
          .createSignedUrl(archivoPath, 60);
          
      return signedUrl;
    } catch (e) {
      print('Error al obtener la URL del PDF: $e');
      return null;
    }
  }
}