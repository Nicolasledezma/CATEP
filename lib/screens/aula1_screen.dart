import 'package:flutter/material.dart';

class FormularioAula1 extends StatefulWidget {
  const FormularioAula1({super.key});

  @override
  State<FormularioAula1> createState() => _FormularioAula1State();
}

class _FormularioAula1State extends State<FormularioAula1> {
  // Estado del Switch (Limpieza)
  bool _limpiezaArea = false;

  // Variables para los botones de selección (null = sin marcar, true = Operativo, false = No Operativo)
  bool? _mobiliario;
  bool? _controlTv;
  bool? _monitor;
  bool? _cables;
  bool? _cpu;
  bool? _mouse;
  bool? _teclado;

  // Controlador para la caja de texto
  final _observacionesController = TextEditingController();

  // Configuración del ícono del Switch (Check y X)
  static const WidgetStateProperty<Icon> thumbIcon =
      WidgetStateProperty<Icon>.fromMap(<WidgetStatesConstraint, Icon>{
    WidgetState.selected: Icon(Icons.check, color: Colors.green),
    WidgetState.any: Icon(Icons.close, color: Colors.red),
  });

  // Función constructora para no repetir el código de las filas con botones
  Widget _buildFilaEvaluacion(String item, bool? valorActual, Function(bool?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Nombre del ítem (Ocupa la mitad del espacio)
          Expanded(
            flex: 2,
            child: Text(item, style: const TextStyle(fontSize: 16)),
          ),
          // Botón Operativo (Centro)
          Expanded(
            flex: 1,
            child: Radio<bool>(
              value: true,
              groupValue: valorActual,
              onChanged: onChanged,
              activeColor: Colors.green, // Se pone verde si funciona
            ),
          ),
          // Botón No Operativo (Derecha)
          Expanded(
            flex: 1,
            child: Radio<bool>(
              value: false,
              groupValue: valorActual,
              onChanged: onChanged,
              activeColor: Colors.red, // Se pone rojo si está dañado
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _observacionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Diario - Aula 1'),
        backgroundColor: const Color(0xFFD32F2F), // Rojo de Planta Alta
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Texto de Instrucciones
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: const Text(
                'Si tras su revisión no hay novedad marca el botón (Operativo y funcional), '
                'si observas una falla marca el botón (No operativo / no funciona).\n\n'
                'Es IMPORTANTE que indiques el detalle en "Observaciones".',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Limpieza del Área (Tu Switch personalizado)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Limpieza del área', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Switch(
                  thumbIcon: thumbIcon,
                  value: _limpiezaArea,
                  activeColor: Colors.green, // ¡Aquí lo volvemos verde!
                  activeTrackColor: Colors.green.shade200,
                  inactiveThumbColor: Colors.red,
                  inactiveTrackColor: Colors.red.shade200,
                  onChanged: (bool value) {
                    setState(() {
                      _limpiezaArea = value;
                    });
                  },
                ),
              ],
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 10),

            // 3. Encabezados de las columnas
            const Row(
              children: [
                Expanded(flex: 2, child: Text('Verificación', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 1, child: Text('Operativo\ny funcional', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green))),
                Expanded(flex: 1, child: Text('No operativo\nNo funcional', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red))),
              ],
            ),
            const SizedBox(height: 10),

            // 4. Filas de Evaluación Generales
            _buildFilaEvaluacion('Mobiliario (mesas y sillas)', _mobiliario, (val) => setState(() => _mobiliario = val)),
            _buildFilaEvaluacion('Control TV', _controlTv, (val) => setState(() => _controlTv = val)),
            
            const SizedBox(height: 15),
            
            // 5. Sección de Computadora Desglosada
            const Text('Computadora', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0), // Indentación para que parezca una sub-lista
              child: Column(
                children: [
                  _buildFilaEvaluacion('Monitor', _monitor, (val) => setState(() => _monitor = val)),
                  _buildFilaEvaluacion('Cables', _cables, (val) => setState(() => _cables = val)),
                  _buildFilaEvaluacion('CPU', _cpu, (val) => setState(() => _cpu = val)),
                  _buildFilaEvaluacion('Mouse', _mouse, (val) => setState(() => _mouse = val)),
                  _buildFilaEvaluacion('Teclado', _teclado, (val) => setState(() => _teclado = val)),
                ],
              ),
            ),
            
            const SizedBox(height: 20),

            // 6. Caja de Observaciones
            const Text('Observaciones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _observacionesController,
              decoration: const InputDecoration(
                hintText: 'Describe cualquier falla encontrada...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: 4, // Caja grande como pediste
            ),

            const SizedBox(height: 30),

            // 7. Botón de Enviar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Aquí conectaremos con Supabase luego
                },
                child: const Text('Guardar Control Diario', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}