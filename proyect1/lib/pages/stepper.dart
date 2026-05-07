import 'package:flutter/material.dart';

import 'package:proyect1/pages/us.dart';
import 'package:proyect1/pages/stepper.dart';

class AppTutorialStepper extends StatefulWidget {
  const AppTutorialStepper({super.key});

  @override
  State<AppTutorialStepper> createState() => _AppTutorialStepperState();
}

class _AppTutorialStepperState extends State<AppTutorialStepper> {
  int currentStep = 0;

  final List<Map<String, dynamic>> steps = [
    {
      "title": "Abre la App",
      "description":
          "Inicia Satori y permite que la aplicación te acompañe antes de entrar a redes sociales o aplicaciones distractoras.",
      "icon": Icons.phone_android,
    },
    {
      "title": "Elige tu emoción",
      "description":
          "Selecciona cómo te sientes actualmente: ansiedad, tristeza, aburrimiento o estrés.",
      "icon": Icons.mood,
    },
    {
      "title": "Espera unos segundos",
      "description":
          "La aplicación activa una pausa consciente para romper el impulso automático de usar el celular.",
      "icon": Icons.timer,
    },
    {
      "title": "Realiza el ejercicio",
      "description":
          "Completa una actividad breve como respiración guiada, lectura ligera o una microacción relajante.",
      "icon": Icons.self_improvement,
    },
    {
      "title": "Deja el teléfono",
      "description":
          "Después de la intervención, decide conscientemente si realmente deseas continuar usando el dispositivo.",
      "icon": Icons.spa,
    },
  ];

  void nextStep() {
    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 252, 250, 1),

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

      body: Column(
        children: [

          const SizedBox(height: 20),

          const Text(
            "Tutorial",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Divider(
            color: Colors.black,
            thickness: 1.5,
            indent: 120,
            endIndent: 120,
          ),

          Expanded(
            child: Stepper(
              currentStep: currentStep,
              type: StepperType.vertical,

              onStepContinue: nextStep,
              onStepCancel: previousStep,

              controlsBuilder: (context, details) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: details.onStepContinue,
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(
                          currentStep == steps.length - 1
                              ? "Finalizar"
                              : "Continuar",
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (currentStep > 0)
                        OutlinedButton.icon(
                          onPressed: details.onStepCancel,
                          icon: const Icon(Icons.arrow_back),
                          label: const Text("Regresar"),
                        ),
                    ],
                  ),
                );
              },

              steps: List.generate(
                steps.length,
                (index) {
                  return Step(
                    isActive: currentStep >= index,
                    state: currentStep > index
                        ? StepState.complete
                        : StepState.indexed,

                    title: Row(
                      children: [
                        Icon(
                          steps[index]["icon"],
                          color: const Color.fromRGBO(196, 211, 188, 1),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          steps[index]["title"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    content: Text(
                      steps[index]["description"],
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}