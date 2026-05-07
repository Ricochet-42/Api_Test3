import 'package:flutter/material.dart';
import 'package:proyect1/pages/quotes_api.dart';
import 'package:proyect1/widgets/CognitiveCard.dart';

import 'package:proyect1/pages/us.dart';
import 'package:proyect1/pages/stepper.dart';

class RedireccionCognitiva extends StatefulWidget {
  const RedireccionCognitiva({super.key});

  @override
  State<RedireccionCognitiva> createState() => _RedireccionCognitivaState();
}

class _RedireccionCognitivaState extends State<RedireccionCognitiva> {

  List<Map<String,String>> frases = [];

  @override
  void initState() {
    super.initState();
    cargarFrases();
  }

  Future<void> cargarFrases() async {

    try {

      List<Map<String,String>> temp = [];

      for(int i = 0; i < 6; i++){

        final data = await QuoteService.obtenerFrase();

        temp.add({
          "titulo": data["author"],
          "contenido": data["quote"]
        });

      }

      setState(() {
        frases = temp;
      });

    } catch(e) {
      print(e);
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

          const SizedBox(height: 40),

          const Text(
            'Redirección Cognitiva',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),
          const Divider(
            color: Colors.black,
            thickness: 1.5,
            indent: 100,
            endIndent: 100,
          ),
          
          const SizedBox(height: 20),
          SizedBox(
            height: 350,
            child: frases.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : PageView(
                    controller: PageController(viewportFraction: 0.85),
                    children: frases.map((frase) {

                      return CognitiveCard(
                        titulo: frase["titulo"]!,
                        contenido: frase["contenido"]!,
                      );

                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}