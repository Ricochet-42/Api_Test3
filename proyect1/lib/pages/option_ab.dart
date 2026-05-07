import 'package:flutter/material.dart';
import 'package:proyect1/main.dart';
import 'package:proyect1/widgets/BotonCounter.dart';
import 'package:proyect1/widgets/InfoCard.dart';

import 'package:proyect1/pages/us.dart';
import 'package:proyect1/pages/stepper.dart';

class ActivacionRapida extends StatelessWidget {
  const ActivacionRapida({super.key});

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
            'Activa tu mente',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
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
              'Elige una actividad rápida (30s – 2 min)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 🔥 SLIDER (GANCHO PRINCIPAL)
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: PageView(
                controller: PageController(viewportFraction: 0.85),
                children: const [

  InfoCard(
    titulo: "Mini reto mental",
    imagen: "https://picsum.photos/400/200",
    descripcion:
        "Cuenta hacia atrás desde 100 de 7 en 7 durante 30 segundos.",
    link: "https://www.google.com",
  ),

  InfoCard(
    titulo: "Garabato creativo",
    imagen: "https://picsum.photos/401/200",
    descripcion:
        "Dibuja cualquier cosa sin pensar durante 1 minuto.",
    link: "https://www.google.com",
  ),

  InfoCard(
    titulo: "Palabra nueva",
    imagen: "https://picsum.photos/402/200",
    descripcion:
        "Aprende una palabra nueva y úsala en una frase.",
    link: "https://www.google.com",
  ),

  InfoCard(
    titulo: "Respiración profunda",
    imagen: "https://picsum.photos/403/200",
    descripcion:
        "Respira lentamente durante 30 segundos e intenta relajarte.",
    link: "https://www.google.com",
  ),

  InfoCard(
    titulo: "Observa tu entorno",
    imagen: "https://picsum.photos/404/200",
    descripcion:
        "Encuentra 5 objetos de color verde a tu alrededor.",
    link: "https://www.google.com",
  ),

  InfoCard(
    titulo: "Estiramiento rápido",
    imagen: "https://picsum.photos/405/200",
    descripcion:
        "Levántate y realiza un pequeño estiramiento durante 1 minuto.",
    link: "https://www.google.com",
  ),

],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 🎯 ESCALAMIENTO
          const Text(
            "¿Quieres seguir?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            "Continúa 5 minutos más o prueba otra actividad",
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 15),

          // 🔻 BOTÓN
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