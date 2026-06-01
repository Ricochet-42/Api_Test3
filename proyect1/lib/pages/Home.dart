import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proyect1/pages/option_ab.dart';
import 'package:proyect1/pages/contador.dart';
import 'package:proyect1/pages/quotes.dart';
import 'package:proyect1/pages/us.dart';
import 'package:proyect1/pages/stepper.dart';
import 'package:proyect1/pages/option_tri.dart';
import 'package:proyect1/pages/option_imp.dart';
import 'package:proyect1/pages/option_ans.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:proyect1/pages/recomendaciones.dart';
import 'package:proyect1/pages/desk.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _tutorialActivo = true;
  
  // Obtenemos el usuario actual de Firebase para mostrar su nombre o correo
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _mostrarTutorialInicial();
  }

  Future<void> _initializePlayer() async {
    try {
      await _audioPlayer.setSourceAsset('music/cancion1.mp3');
    } catch (e) {
      debugPrint('Error al cargar la canción: $e');
    }
  }

  Future<void> _toggleMusic() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _audioPlayer.play(AssetSource('music/cancion1.mp3'));
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _mostrarTutorialInicial() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_tutorialActivo && mounted) {
        _mostrarPaso1();
      }
    });
  }

  void _mostrarPaso1() {
    if (!_tutorialActivo || !mounted) return;
    
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Tutorial",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => Container(),
      transitionBuilder: (context, anim1, anim2, child) {
        return Stack(
          children: [
            FadeTransition(
              opacity: anim1,
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Positioned(
              top: 100,
              right: 40,
              child: ScaleTransition(
                scale: anim1,
                child: _buildTutorialCard(
                  icon: Icons.menu,
                  title: '¡Explora el menú!',
                  description: 'Aquí encontrarás el tutorial\ncompleto y más opciones.',
                  onNext: () {
                    Navigator.of(context).pop();
                    _mostrarPaso2();
                  },
                  onSkip: () {
                    Navigator.of(context).pop();
                    _cerrarTutorial();
                  },
                  color: const Color.fromRGBO(196, 211, 188, 1),
                ),
              ),
            ),
            Positioned(
              top: 85,
              right: 90,
              child: FadeTransition(
                opacity: anim1,
                child: CustomPaint(
                  size: const Size(25, 25),
                  painter: ArrowPainter(Colors.white, 'right'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _mostrarPaso2() {
    if (!_tutorialActivo || !mounted) return;
    
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Tutorial",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => Container(),
      transitionBuilder: (context, anim1, anim2, child) {
        return Stack(
          children: [
            FadeTransition(
              opacity: anim1,
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.35,
              left: MediaQuery.of(context).size.width / 2 - 140,
              child: ScaleTransition(
                scale: anim1,
                child: _buildTutorialCard(
                  icon: Icons.emoji_emotions,
                  title: '¿Cómo te sientes?',
                  description: 'Selecciona la emoción que estás\nexperimentando ahora mismo.',
                  onNext: () {
                    Navigator.of(context).pop();
                    _mostrarPaso3();
                  },
                  onSkip: () {
                    Navigator.of(context).pop();
                    _cerrarTutorial();
                  },
                  color: const Color.fromRGBO(196, 211, 188, 1),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.38,
              left: MediaQuery.of(context).size.width / 2 - 100,
              child: FadeTransition(
                opacity: anim1,
                child: CustomPaint(
                  size: const Size(25, 25),
                  painter: ArrowPainter(Colors.white, 'up'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _mostrarPaso3() {
    if (!_tutorialActivo || !mounted) return;
    
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Tutorial",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => Container(),
      transitionBuilder: (context, anim1, anim2, child) {
        return Stack(
          children: [
            FadeTransition(
              opacity: anim1,
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Positioned(
              bottom: 80,
              left: MediaQuery.of(context).size.width / 2 - 140,
              child: ScaleTransition(
                scale: anim1,
                child: _buildTutorialCard(
                  icon: Icons.more_horiz_outlined,
                  title: '¡Actividades extras!',
                  description: 'Aquí encontrarás:\n• Chatbot interactivo\n• Espacio de trabajo\n• Recomendaciones\n• Frases motivacionales',
                  onNext: () {
                    Navigator.of(context).pop();
                    _cerrarTutorial();
                  },
                  onSkip: () {
                    Navigator.of(context).pop();
                    _cerrarTutorial();
                  },
                  color: const Color.fromRGBO(196, 211, 188, 1),
                  isLast: true,
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: FadeTransition(
                opacity: anim1,
                child: CustomPaint(
                  size: const Size(25, 25),
                  painter: ArrowPainter(Colors.white, 'up'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTutorialCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onNext,
    required VoidCallback onSkip,
    required Color color,
    bool isLast = false,
  }) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color.fromRGBO(250, 252, 250, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromRGBO(80, 90, 75, 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: onSkip,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[600],
                ),
                child: const Text(
                  'Saltar',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  elevation: 0,
                ),
                child: Text(
                  isLast ? 'Comenzar' : 'Siguiente →',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _cerrarTutorial() {
    if (mounted) {
      setState(() {
        _tutorialActivo = false;
      });
    }
  }

  Future<void> _logout() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      }
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushReplacementNamed(context, 'login');
      }
    } catch (e) {
      debugPrint('Error al cerrar sesión: $e');
    }
  }

  void _mostrarMenuExtras() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(196, 211, 188, 0.3),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(196, 211, 188, 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Actividades Extras',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(80, 90, 75, 1),
                ),
              ),
              const SizedBox(height: 20),
              
              _buildExtraOption(
                icon: Icons.chat_bubble_outline,
                title: 'Chatbot',
                subtitle: 'Habla con Tito, asistente virtual',
                color: const Color.fromRGBO(196, 211, 188, 0.15),
                iconColor: const Color.fromRGBO(196, 211, 188, 1),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'chat');
                },
              ),
              
              const SizedBox(height: 12),
              
              _buildExtraOption(
                icon: Icons.work_outline,
                title: 'Espacio de trabajo',
                subtitle: 'Organiza tus tareas con Pomodoro',
                color: const Color.fromRGBO(233, 237, 227, 0.5),
                iconColor: const Color.fromRGBO(80, 90, 75, 1),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EspacioTrabajoPage(),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 12),
              
              _buildExtraOption(
                icon: Icons.recommend_outlined,
                title: 'Recomendaciones',
                subtitle: 'Contenido personalizado para ti',
                color: const Color.fromRGBO(245, 245, 245, 0.8),
                iconColor: const Color.fromRGBO(80, 90, 75, 1),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RecomendacionesPage(),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 12),
              
              _buildExtraOption(
                icon: Icons.format_quote,
                title: 'Frases motivacionales',
                subtitle: 'Inspírate con frases positivas',
                color: const Color.fromRGBO(196, 211, 188, 0.15),
                iconColor: const Color.fromRGBO(196, 211, 188, 1),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RedireccionCognitiva2(),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 20),
              
             
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExtraOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, size: 26, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(80, 90, 75, 1),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Si el usuario tiene DisplayName usamos ese, si no, usamos la parte inicial de su correo
    String userName = _currentUser?.displayName ?? 
                       _currentUser?.email?.split('@')[0] ?? 
                       'Usuario';

    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 252, 250, 1),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          onPressed: _mostrarMenuExtras,
          backgroundColor: const Color.fromRGBO(196, 211, 188, 1),
          elevation: 5,
          child: const Icon(
            Icons.more_horiz_outlined,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.95,
            colors: [
              const Color.fromRGBO(250, 252, 250, 1),
              const Color.fromRGBO(240, 245, 235, 1),
            ],
            stops: const [0.3, 1.0],
          ),
        ),
        child: Column(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(180), // Incrementado ligeramente para el saludo
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: AppBar(
                  toolbarHeight: 180,
                  elevation: 8,
                  shadowColor: Colors.black.withOpacity(0.2),
                  backgroundColor: const Color.fromRGBO(196, 211, 188, 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(60),
                    ),
                  ),
                  centerTitle: true,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.music_note : Icons.music_off,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: _toggleMusic,
                      tooltip: _isPlaying ? 'Pausar música' : 'Reproducir música',
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "SATORI",
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                blurRadius: 5,
                                color: Colors.black12,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "¡Bienvenido, $userName!",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 10),
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, size: 28, color: Colors.white),
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
                          } else if (value == 'Estadisticas') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PanelEstadisticas(
                                  onCerrar: () => Navigator.pop(context),
                                ),
                              ),
                            );
                          }
                          else if (value == 'Cerrar') {
                            _logout();
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'perfil',
                            child: Row(
                              children: [
                                Icon(Icons.school, size: 20, color: Color.fromRGBO(196, 211, 188, 1)),
                                SizedBox(width: 10),
                                Text('Tutorial'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'config',
                            child: Row(
                              children: [
                                Icon(Icons.info, size: 20, color: Color.fromRGBO(196, 211, 188, 1)),
                                SizedBox(width: 10),
                                Text('Sobre nosotros'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'Estadisticas',
                            child: Row(
                              children: [
                                Icon(Icons.bar_chart, size: 20, color: Color.fromRGBO(196, 211, 188, 1)),
                                SizedBox(width: 10),
                                Text('Estadísticas'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'Cerrar',
                            child: Row(
                              children: [
                                Icon(Icons.exit_to_app, size: 20, color: Color.fromRGBO(196, 211, 188, 1)),
                                SizedBox(width: 10),
                                Text('Cerrar sesión'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 25),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: const Text(
                'Selecciona cómo te sientes en este momento',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 41, 41, 41),
                ),
              ),
            ),
            
            const SizedBox(height: 8),

            SizedBox(
              width: 200,
              child: const Divider(
                color: Color.fromRGBO(196, 211, 188, 1),
                thickness: 2,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1,
                  children: [
                    BotonConContador(
                      imagePath: 'assets/icons/aburrido.png',
                      text: "Aburrimiento",
                      screen: const ActivacionRapida(),
                      tipo: 'aburrimiento',
                    ),
                    BotonConContador(
                      imagePath: 'assets/icons/enfermo.png',
                      text: "Ansiedad",
                      screen: const AnsiedadFlow(),
                      tipo: 'ansiedad',
                    ),
                    BotonConContador(
                      imagePath: 'assets/icons/nervioso.png',
                      text: "Impulso",
                      screen: const RedireccionCognitiva(),
                      tipo: 'impulso',
                    ),
                    BotonConContador(
                      imagePath: 'assets/icons/triste.png',
                      text: "Tristeza",
                      screen: const TristezaFlow(),
                      tipo: 'tristeza',
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Column(
                children: [
                  SizedBox(
                    width: 150,
                    child: const Divider(
                      color: Color.fromRGBO(196, 211, 188, 1),
                      thickness: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '"Tu celular ya tiene suficiente batería,\nahora tú cuida la tuya."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 104, 104, 104),
                    ),
                  ),
                ],
              ),
            ),
            
            // Botón de Cerrar Sesión (Alineado correctamente al final de la columna principal)
           
            const SizedBox(height: 100), // Espaciado para que no choque con el FloatingActionButton
          ],
        ),
      ),
      
      bottomNavigationBar: Container(
        height: 25,
        color: Colors.black87,
        child: const Center(
          child: Text(
            '@satorico',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final Color color;
  final String direction;

  ArrowPainter(this.color, this.direction);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    switch (direction) {
      case 'right':
        path.moveTo(0, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height);
        break;
      case 'left':
        path.moveTo(size.width, 0);
        path.lineTo(0, size.height / 2);
        path.lineTo(size.width, size.height);
        break;
      case 'up':
        path.moveTo(0, size.height);
        path.lineTo(size.width / 2, 0);
        path.lineTo(size.width, size.height);
        break;
      case 'down':
        path.moveTo(0, 0);
        path.lineTo(size.width / 2, size.height);
        path.lineTo(size.width, 0);
        break;
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LoadingScreen extends StatefulWidget {
  final Widget destino;

  const LoadingScreen({super.key, required this.destino});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => widget.destino),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(196, 211, 188, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitWaveSpinner(
              color: Colors.white,
              size: 120.0,
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Cargando...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  shadows: [],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}