import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoCard extends StatelessWidget {
  final String titulo;
  final String imagen;
  final String descripcion;
  final String link;

  const InfoCard({
    super.key,
    required this.titulo,
    required this.imagen,
    required this.descripcion,
    required this.link,
  });

  Future<void> abrirLink() async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('No se pudo abrir el link');
    }
  }

@override
Widget build(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    padding: const EdgeInsets.all(15), // 👈 padding general
    decoration: BoxDecoration(
      color: Color.fromRGBO(250, 252, 250, 1),
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(3, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min, // 👈 se ajusta al contenido
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        // 🔹 TITULO
        Text(
          titulo,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        // 🔹 IMAGEN
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            imagen,
            width: 200,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 10),

        // 🔹 DESCRIPCIÓN
        Text(
          descripcion,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
        ),

        const SizedBox(height: 25),

        // 🔹 BOTON
        SizedBox(
          width: double.infinity,
          height: 25,
          child: ElevatedButton(
            onPressed: abrirLink,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(233, 237, 227, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text("Ver más"),
          ),
        ),

        const SizedBox(height: 20), // 👈 EXACTO lo que pediste
      ],
    ),
  );
}
}