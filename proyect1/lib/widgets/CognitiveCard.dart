import 'package:flutter/material.dart';

class CognitiveCard extends StatelessWidget {
  final String titulo;
  final String contenido;

  const CognitiveCard({
    super.key,
    required this.titulo,
    required this.contenido,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

height: 180,
      // 🔹 separación horizontal
      margin: const EdgeInsets.symmetric(horizontal: 10),

      decoration: BoxDecoration(
        color: const Color.fromRGBO(250, 252, 250, 1),

        borderRadius: BorderRadius.circular(20),


  // 🔹 sombra abajo
  boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(3, 3),
        ),
      ],
        // 🔹 sombra
        
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              titulo,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              contenido,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}