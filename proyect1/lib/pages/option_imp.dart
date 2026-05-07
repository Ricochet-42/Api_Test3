import 'package:flutter/material.dart';
import 'package:proyect1/main.dart';
import 'package:proyect1/widgets/BotonCounter.dart';
import 'package:proyect1/pages/us.dart';
import 'package:proyect1/pages/stepper.dart';

// 🔹 NUEVO WIDGET (puedes duplicar tu InfoCard y renombrarlo)
import 'package:proyect1/widgets/CognitiveCard.dart';

class RedireccionCognitiva extends StatelessWidget {
  const RedireccionCognitiva({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 252, 250, 1),

      // 🔹 APPBAR
      appBar: PreferredSize(
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
                itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'perfil',
                child: Text('Tutorial'),
              ),
              const PopupMenuItem(
                value: 'config',
                child: Text('Sobre nosotros'),
              ),
            ],
              ),
            ],
          ),
        ),
      ),

      // 🔹 BODY
      body: Column(
        children: [
          const SizedBox(height: 40),

          const Text(
            'Redirección Cognitiva',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Divider(
            color: Colors.black,
            thickness: 1.5,
            indent: 100,
            endIndent: 100,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Lee esto antes de continuar...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 🔥 TARJETAS COGNITIVAS
          SizedBox(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: PageView(
                controller: PageController(viewportFraction: 0.85),
                children: const [

  CognitiveCard(
    titulo: "Curiosidad",
    contenido:
        "El cerebro tarda aproximadamente 90 segundos en procesar y reducir una emoción intensa.",
  ),

  CognitiveCard(
    titulo: "Mini dato",
    contenido:
        "Leer solo 1 minuto puede reducir significativamente el estrés mental.",
  ),

  CognitiveCard(
    titulo: "Pregunta",
    contenido:
        "¿Esto que quieres hacer ahora te acerca a quien quieres ser?",
  ),

  CognitiveCard(
    titulo: "Reflexión",
    contenido:
        "Muchas veces tomamos el celular por impulso y no por verdadera necesidad.",
  ),

  CognitiveCard(
    titulo: "Dato mental",
    contenido:
        "Respirar profundamente ayuda a disminuir la activación del sistema nervioso.",
  ),

  CognitiveCard(
    titulo: "Pausa",
    contenido:
        "Tomarte unos segundos antes de actuar puede ayudarte a recuperar el control.",
  ),

],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 🎯 MICRO CONTROL DEL IMPULSO
          const Text(
            "¿Sigues queriendo entrar?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Espera 10 segundos más...",
            style: TextStyle(
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 20),

          // 🔻 BOTÓN FINAL
          Padding(
            padding: const EdgeInsets.all(20),
            child: BotonCounter(
              destino: const MyApp(),
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 NUEVAS PANTALLAS (renombradas)
class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Perfil")),
    );
  }
}

class PantallaConfig extends StatelessWidget {
  const PantallaConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Configuración")),
    );
  }
}