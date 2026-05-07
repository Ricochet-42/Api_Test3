import 'package:flutter/material.dart';
import 'api_bot.dart';

class Tito extends StatelessWidget {
  const Tito({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String respuesta = "Hola, soy Tito asistente virtual personal";
  final TextEditingController mensajeController = TextEditingController();

  Future<void> obtenerRespuesta() async {

    String mensaje = mensajeController.text;

    if (mensaje.isEmpty) return;

    setState(() {
      respuesta = "Tito está escribiendo...";
    });

    try {

      String result = await chatWithLlama(mensaje);

      setState(() {
        respuesta = result;
      });

    } catch (e) {

      setState(() {
        respuesta = "Error: $e";
      });

    }

    mensajeController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
backgroundColor: Color.fromRGBO(250, 252, 250, 1),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: AppBar(

            automaticallyImplyLeading: true,

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
                onSelected: (value) {},
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'perfil',
                    child: Text('Perfil'),
                  ),
                  PopupMenuItem(
                    value: 'config',
                    child: Text('Configuración'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child: Container(

          width: 350,
          height: 500,

          padding: const EdgeInsets.all(20),

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
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [

                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(196, 211, 188, 1),
                    child: Icon(
                      Icons.face_retouching_natural,
                      color: Color.fromARGB(255, 249, 249, 249),
                    ),
                  ),

                  SizedBox(width: 10),

                  Text(
                    "Tito",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:Color.fromRGBO(196, 211, 188, 1),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Expanded(
                child: Container(

                  width: double.infinity,

                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F8E9),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: SingleChildScrollView(
                    child: Text(
                      respuesta,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [

                  Expanded(
                    child: TextField(

                      controller: mensajeController,

                      decoration: InputDecoration(
                        hintText: "Escribe un mensaje...",
                        filled: true,
                        fillColor: const Color.fromRGBO(233, 237, 227, 1),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton(

                    onPressed: obtenerRespuesta,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(188, 193, 181, 1),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}