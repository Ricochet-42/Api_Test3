import 'package:flutter/material.dart';
import 'package:proyect1/pages/us.dart';
import 'package:proyect1/pages/stepper.dart';
import 'dart:async';

class EspacioTrabajoPage extends StatefulWidget {
  const EspacioTrabajoPage({super.key});

  @override
  State<EspacioTrabajoPage> createState() => _EspacioTrabajoPageState();
}

class _EspacioTrabajoPageState extends State<EspacioTrabajoPage> {
  // Estado del Pomodoro (sin pausa)
  bool _isWorking = true;
  bool _isActive = false;
  int _tiempoRestante = 25 * 60;
  Timer? _timer;
  
  int _tiempoTrabajo = 25;
  int _tiempoDescanso = 5;
  
  // Lista de tareas
  List<Tarea> _tareas = [];
  
  final TextEditingController _trabajoController = TextEditingController();
  final TextEditingController _descansoController = TextEditingController();
  final TextEditingController _tareaController = TextEditingController();
  
  // Notificaciones=

  @override
  void initState() {
    super.initState();
    // Inicializar notificaciones
    
    // Agregar algunas tareas de ejemplo
    _tareas = [
      Tarea(titulo: "Revisar documentación", completada: false),
      Tarea(titulo: "Organizar archivos", completada: false),
      Tarea(titulo: "Planificar reunión", completada: false),
    ];
  }

  void _iniciarPomodoro() {
    if (!_isActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (_tiempoRestante > 0) {
          setState(() {
            _tiempoRestante--;
          });
          // Actualizar notificación cada 5 segundos para no sobrecargar
          if (_tiempoRestante % 5 == 0 || _tiempoRestante <= 10) {
          }
        } else {
          _cambiarModo();
        }
      });
      setState(() {
        _isActive = true;
      });
    }
  }

  void _cambiarModo() {
    _timer?.cancel();
    setState(() {
      _isWorking = !_isWorking;
      _tiempoRestante = (_isWorking ? _tiempoTrabajo : _tiempoDescanso) * 60;
      _isActive = false;
    });
    
    
    _mostrarSnackBar(
      _isWorking ? "Tiempo de trabajo" : "Tiempo de descanso",
      _isWorking ? "Vuelve al trabajo" : "Tómate un respiro"
    );
  }

  void _reiniciarPomodoro() {
    _timer?.cancel();
    setState(() {
      _isWorking = true;
      _tiempoRestante = _tiempoTrabajo * 60;
      _isActive = false;
    });
  }

  void _mostrarConfiguracion() {
    _trabajoController.text = _tiempoTrabajo.toString();
    _descansoController.text = _tiempoDescanso.toString();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          '⚙️ Configurar Pomodoro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _trabajoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tiempo de trabajo (minutos)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.work),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _descansoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tiempo de descanso (minutos)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.coffee),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _tiempoTrabajo = int.tryParse(_trabajoController.text) ?? 25;
                _tiempoDescanso = int.tryParse(_descansoController.text) ?? 5;
                _tiempoRestante = _tiempoTrabajo * 60;
                _isWorking = true;
                _isActive = false;
                _timer?.cancel();
              });
              Navigator.pop(context);
              _mostrarSnackBar(
                "Tiempos actualizados",
                "Trabajo: $_tiempoTrabajo min | Descanso: $_tiempoDescanso min"
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(196, 211, 188, 1),
              foregroundColor: Colors.black,
            ),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _agregarTarea() {
    _tareaController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          '📝 Nueva Tarea',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: _tareaController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Escribe tu tarea aquí...',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.edit_note),
          ),
          onSubmitted: (_) => _guardarTarea(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: _guardarTarea,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(196, 211, 188, 1),
              foregroundColor: Colors.black,
            ),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _guardarTarea() {
    if (_tareaController.text.trim().isNotEmpty) {
      setState(() {
        _tareas.add(Tarea(
          titulo: _tareaController.text.trim(),
          completada: false,
        ));
      });
      Navigator.pop(context);
      _mostrarSnackBar(
        "Tarea agregada",
        _tareaController.text.trim()
      );
    }
  }

  void _toggleTarea(int index) {
    setState(() {
      _tareas[index].completada = !_tareas[index].completada;
    });
  }

  void _eliminarTarea(int index) {
    setState(() {
      _tareas.removeAt(index);
    });
    _mostrarSnackBar("Tarea eliminada", "La tarea ha sido removida");
  }

  void _mostrarSnackBar(String titulo, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(mensaje, style: const TextStyle(fontSize: 12)),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color.fromRGBO(196, 211, 188, 1),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  String _formatearTiempo(int segundos) {
    int minutos = segundos ~/ 60;
    int segs = segundos % 60;
    return "${minutos.toString().padLeft(2, '0')}:${segs.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    _trabajoController.dispose();
    _descansoController.dispose();
    _tareaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.95,
            colors: [
              Color.fromRGBO(250, 252, 250, 1),
              Color.fromRGBO(240, 245, 235, 1),
            ],
            stops: [0.3, 1.0],
          ),
        ),
        child: Column(
          children: [
            // AppBar
            PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: AppBar(
                  elevation: 4,
                  backgroundColor: const Color.fromRGBO(196, 211, 188, 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(25),
                    ),
                  ),
                  centerTitle: true,
                  title: const Text(
                    "SATORI",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'perfil') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AppTutorialStepper(),
                            ),
                          );
                        } else if (value == 'config') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PdfPage(),
                            ),
                          );
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'perfil',
                          child: Text('Tutorial'),
                        ),
                        PopupMenuItem(
                          value: 'config',
                          child: Text('Sobre nosotros'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Título
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(196, 211, 188, 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Espacio de Trabajo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(80, 90, 75, 1),
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Tu escritorio virtual para concentrarte',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Barra de herramientas
            _buildToolbar(),

            const SizedBox(height: 20),

            // Mesa de trabajo con tareas (FONDO OSCURO)
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E), // Fondo oscuro
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: const Color.fromRGBO(196, 211, 188, 0.3),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      // Cabecera con botón de agregar
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(196, 211, 188, 0.2),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.red[300],
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.amber[600],
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              "Mis Tareas",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            // Botón de agregar tarea
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(196, 211, 188, 0.8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: IconButton(
                                onPressed: _agregarTarea,
                                icon: const Icon(Icons.add, size: 20),
                                color: const Color.fromRGBO(80, 90, 75, 1),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Lista de tareas con fondo de cuadrícula
                      Expanded(
                        child: Stack(
                          children: [
                            // Fondo de cuadrícula (más sutil en modo oscuro)
                            CustomPaint(
                              size: Size.infinite,
                              painter: CuadriculaMatematicaPainterOscura(),
                            ),
                            // Lista de tareas
                            _tareas.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.checklist,
                                          size: 60,
                                          color: Colors.white.withOpacity(0.2),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "No hay tareas pendientes",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.5),
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Toca el botón + para agregar una",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.3),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    padding: const EdgeInsets.all(12),
                                    itemCount: _tareas.length,
                                    itemBuilder: (context, index) {
                                      return _buildTareaItem(index);
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Pomodoro
            _buildPomodoroBar(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTareaItem(int index) {
    final tarea = _tareas[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(205, 232, 245, 233), // Fondo oscuro para cada tarea
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Checkbox(
          value: tarea.completada,
          onChanged: (_) => _toggleTarea(index),
          activeColor: const Color.fromRGBO(196, 211, 188, 1),
          checkColor: Colors.white,
          side: BorderSide(
            color: tarea.completada 
                ? const Color.fromRGBO(196, 211, 188, 1)
                : Colors.grey.shade600,
            width: 2,
          ),
        ),
        title: Text(
          tarea.titulo,
          style: TextStyle(
            decoration: tarea.completada ? TextDecoration.lineThrough : null,
            decorationColor: Colors.grey,
            decorationThickness: 2,
            color: tarea.completada ? const Color.fromARGB(255, 148, 148, 148) : const Color.fromARGB(255, 3, 3, 3),
            fontWeight: tarea.completada ? FontWeight.normal : FontWeight.w500,
          ),
        ),
        trailing: IconButton(
          onPressed: () => _eliminarTarea(index),
          icon: const Icon(Icons.delete_outline, size: 20),
          color: Colors.grey.shade500,
          tooltip: 'Eliminar tarea',
        ),
        onTap: () => _toggleTarea(index),
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildToolbarIcon(Icons.settings, "Config", () {
            _mostrarConfiguracion();
          }),
          _buildToolbarIcon(Icons.music_note, "Música", () {
            _mostrarSnackBar(" Música", "Reproduciendo música relajante");
          }),
          _buildToolbarIcon(Icons.calculate, "Calc", () {
            _mostrarSnackBar(" Calculadora", "Calculadora simple");
          }),
          _buildToolbarIcon(Icons.note_add, "Notas", () {
            _mostrarSnackBar(" Notas", "Tus notas rápidas");
          }),
          _buildToolbarIcon(Icons.timer, "Timer", () {
            _mostrarSnackBar("⏱ Temporizador", "Temporizador rápido");
          }),
          _buildToolbarIcon(Icons.palette, "Color", () {
            _mostrarSnackBar(" Color", "Cambiar color de fondo");
          }),
        ],
      ),
    );
  }

  Widget _buildToolbarIcon(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: const Color.fromRGBO(117, 119, 114, 1)),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPomodoroBar() {
    double progreso = _isWorking 
        ? 1 - (_tiempoRestante / (_tiempoTrabajo * 60))
        : 1 - (_tiempoRestante / (_tiempoDescanso * 60));
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isWorking
              ? [const Color.fromRGBO(196, 211, 188, 1), const Color.fromRGBO(160, 180, 150, 1)]
              : [const Color.fromRGBO(196, 211, 188, 0.6), const Color.fromRGBO(160, 180, 150, 0.6)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      flex: 2,
      child: Row(
        children: [
          Icon(_isWorking ? Icons.work : Icons.coffee, color: Colors.white, size: 24),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              _isWorking ? "Trabajo" : "Descanso",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
    Flexible(
      flex: 1,
      child: Text(
        _formatearTiempo(_tiempoRestante),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28, fontFamily: 'monospace'),
        textAlign: TextAlign.right,
      ),
    ),
  ],
),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progreso,
            backgroundColor: Colors.white.withOpacity(0.3),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
          const SizedBox(height: 12),
          Wrap(
  spacing: 12,
  runSpacing: 8,
  alignment: WrapAlignment.center,
  children: [
    if (!_isActive)
      ElevatedButton.icon(
        onPressed: _iniciarPomodoro,
        icon: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
        label: const Text("Iniciar", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ElevatedButton.icon(
      onPressed: _reiniciarPomodoro,
      icon: const Icon(Icons.replay, color: Colors.white, size: 20),
      label: const Text("Reiniciar", style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    IconButton(
      onPressed: _mostrarConfiguracion,
      icon: const Icon(Icons.settings, color: Colors.white, size: 24),
    ),
  ],
),
        ],
      ),
    );
  }
}

// Modelo de tarea
class Tarea {
  String titulo;
  bool completada;
  
  Tarea({
    required this.titulo,
    required this.completada,
  });
}

// Painter para dibujar cuadrícula estilo cuaderno matemático (versión oscura)
class CuadriculaMatematicaPainterOscura extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintCuadricula = Paint()
      ..color = const Color.fromRGBO(196, 211, 188, 0.15)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;
    
    final paintLineas = Paint()
      ..color = const Color.fromRGBO(196, 211, 188, 0.25)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    
    // Margen izquierdo (línea roja tipo cuaderno)
    final paintMargen = Paint()
      ..color = const Color(0xFFEF9A9A).withOpacity(0.5)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    
    // Dibujar margen izquierdo
    canvas.drawLine(
      const Offset(50, 0),
      Offset(50, size.height),
      paintMargen,
    );
    
    // Dibujar cuadrícula de puntos
    double spacing = 25;
    for (double x = 60; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paintCuadricula);
      }
    }
    
    // Dibujar líneas horizontales cada 5 cuadros
    for (double y = spacing * 5; y < size.height; y += spacing * 5) {
      canvas.drawLine(
        Offset(60, y),
        Offset(size.width, y),
        paintLineas,
      );
    }
    
    // Dibujar líneas verticales cada 5 cuadros
    for (double x = 60 + spacing * 5; x < size.width; x += spacing * 5) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paintLineas,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}