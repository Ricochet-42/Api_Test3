import 'package:flutter/material.dart';
import 'package:proyect1/pages/us.dart';
import 'package:proyect1/pages/stepper.dart';

class RecomendacionesPage extends StatefulWidget {
  const RecomendacionesPage({super.key});

  @override
  State<RecomendacionesPage> createState() => _RecomendacionesPageState();
}

class _RecomendacionesPageState extends State<RecomendacionesPage> {
  final List<Map<String, dynamic>> actividades = [
    {
      "titulo": "Karate",
      "descripcion": "Arte marcial que mejora la disciplina, concentración y defensa personal. Ideal para liberar estrés y ganar confianza.",
      "icono": Icons.sports_martial_arts,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "45-60 min",
      "dificultad": "⭐️⭐️⭐️",
      "categoria": "Deportes",
    },
    {
      "titulo": "Basketball",
      "descripcion": "Deporte dinámico que mejora resistencia, trabajo en equipo y coordinación. Quema calorías mientras te diviertes.",
      "icono": Icons.sports_basketball,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "60 min",
      "dificultad": "⭐️⭐️⭐️",
      "categoria": "Deportes",
    },
    {
      "titulo": "Scouts",
      "descripcion": "Desarrolla habilidades al aire libre, liderazgo y trabajo en equipo. Aventuras y aprendizaje continuo.",
      "icono": Icons.forest,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "2-3 horas",
      "dificultad": "⭐️⭐️",
      "categoria": "Actividades",
    },
    {
      "titulo": "Yoga",
      "descripcion": "Mejora flexibilidad, reduce ansiedad y conecta mente-cuerpo. Perfecto para relajarte después del trabajo.",
      "icono": Icons.self_improvement,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "30-45 min",
      "dificultad": "⭐️⭐️",
      "categoria": "Bienestar",
    },
    {
      "titulo": "Música",
      "descripcion": "Aprende a tocar guitarra, piano o canto. Estimula la creatividad y reduce el estrés.",
      "icono": Icons.music_note,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "30-60 min",
      "dificultad": "⭐️⭐️⭐️⭐️",
      "categoria": "Arte",
    },
    {
      "titulo": "Lectura",
      "descripcion": "Sumérgete en libros de desarrollo personal, ficción o aprendizaje. Expande tu mente y vocabulario.",
      "icono": Icons.menu_book,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "20-30 min",
      "dificultad": "⭐️",
      "categoria": "Educación",
    },
    {
      "titulo": "Pintura",
      "descripcion": "Expresa tu creatividad con acuarelas, acrílicos o digital. Terapia artística para liberar emociones.",
      "icono": Icons.brush,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "45-60 min",
      "dificultad": "⭐️⭐️",
      "categoria": "Arte",
    },
    {
      "titulo": "Fútbol",
      "descripcion": "Deporte popular que mejora resistencia, velocidad y trabajo en equipo. Ideal para socializar.",
      "icono": Icons.sports_soccer,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "60-90 min",
      "dificultad": "⭐️⭐️⭐️",
      "categoria": "Deportes",
    },
    {
      "titulo": "Teatro",
      "descripcion": "Desarrolla expresión corporal, oratoria y confianza. Supera el miedo escénico mientras te diviertes.",
      "icono": Icons.theater_comedy,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "90 min",
      "dificultad": "⭐️⭐️⭐️",
      "categoria": "Arte",
    },
    {
      "titulo": "Jardinería",
      "descripcion": "Conecta con la naturaleza, reduce ansiedad y cultiva tus propios alimentos. Terapia verde.",
      "icono": Icons.grass,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "30-45 min",
      "dificultad": "⭐️",
      "categoria": "Bienestar",
    },
    {
      "titulo": "Programación",
      "descripcion": "Aprende a crear apps, páginas web o videojuegos. Habilidad del futuro con gran demanda laboral.",
      "icono": Icons.code,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "60 min",
      "dificultad": "⭐️⭐️⭐️⭐️⭐️",
      "categoria": "Educación",
    },
    {
      "titulo": "Fotografía",
      "descripcion": "Captura momentos especiales, aprende composición y edición. Desarrolla tu ojo artístico.",
      "icono": Icons.camera_alt,
      "color": const Color(0xFF757575),
      "gradiente": [Color(0xFF757575), Color(0xFF9E9E9E)],
      "duracion": "45-60 min",
      "dificultad": "⭐️⭐️",
      "categoria": "Arte",
    },
  ];

  String categoriaSeleccionada = "Todas";
  final List<String> categorias = ["Todas", "Deportes", "Arte", "Bienestar", "Educación", "Actividades"];

  List<Map<String, dynamic>> get actividadesFiltradas {
    if (categoriaSeleccionada == "Todas") {
      return actividades;
    }
    return actividades.where((act) => act["categoria"] == categoriaSeleccionada).toList();
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

            // Contenido principal
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    
                    // Título redondeado
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(196, 211, 188, 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Actividades Recomendadas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(80, 90, 75, 1),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Descubre actividades para tu bienestar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Filtros por categoría
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: categorias.length,
                        itemBuilder: (context, index) {
                          final categoria = categorias[index];
                          final isSelected = categoria == categoriaSeleccionada;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FilterChip(
                              label: Text(categoria),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  categoriaSeleccionada = categoria;
                                });
                              },
                              backgroundColor: Colors.white,
                              selectedColor: const Color.fromRGBO(196, 211, 188, 0.3),
                              checkmarkColor: const Color.fromRGBO(196, 211, 188, 1),
                              labelStyle: TextStyle(
                                color: isSelected 
                                    ? const Color.fromRGBO(80, 90, 75, 1)
                                    : Colors.grey,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                              shape: StadiumBorder(
                                side: BorderSide(
                                  color: isSelected
                                      ? const Color.fromRGBO(196, 211, 188, 1)
                                      : Colors.grey.withOpacity(0.3),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Lista de actividades
                    if (actividadesFiltradas.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 50),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off, size: 60, color: Colors.grey),
                              SizedBox(height: 10),
                              Text(
                                "No hay actividades en esta categoría",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: actividadesFiltradas.length,
                        itemBuilder: (context, index) {
                          final actividad = actividadesFiltradas[index];
                          return _buildTarjetaActividad(actividad);
                        },
                      ),
                    
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTarjetaActividad(Map<String, dynamic> actividad) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFE8F5E9),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _mostrarDialogoActividad(actividad);
          },
          borderRadius: BorderRadius.circular(25),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icono circular con gradiente gris
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: const [Color(0xFF757575), Color(0xFF9E9E9E)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    actividad["icono"],
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Contenido a la derecha
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              actividad["titulo"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(80, 90, 75, 1),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF757575), Color(0xFF9E9E9E)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              actividad["categoria"],
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        actividad["descripcion"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.timer, size: 12, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            actividad["duracion"],
                            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            actividad["dificultad"],
                            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoActividad(Map<String, dynamic> actividad) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF757575), Color(0xFF9E9E9E)],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                actividad["icono"],
                size: 28,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                actividad["titulo"],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              actividad["descripcion"],
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timer, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text("Duración: ${actividad["duracion"]}"),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.emoji_events, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text("Dificultad: ${actividad["dificultad"]}"),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.category, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text("Categoría: ${actividad["categoria"]}"),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("¡Excelente elección! Empieza con ${actividad["titulo"]} 🎉"),
                  duration: const Duration(seconds: 2),
                  backgroundColor: const Color.fromRGBO(196, 211, 188, 1),
                ),
              );
            },
            icon: const Icon(Icons.info_outline, size: 18),
            label: const Text("Ver más"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(196, 211, 188, 1),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}