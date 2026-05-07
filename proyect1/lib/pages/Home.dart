import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proyect1/widgets/animatedbutton.dart';
import 'package:proyect1/pages/option_ab.dart';

import 'package:proyect1/pages/chatbot.dart';

import 'package:proyect1/pages/us.dart';
import 'package:proyect1/pages/stepper.dart';
import 'package:proyect1/pages/option_tri.dart';
import 'package:proyect1/pages/option_imp.dart';
import 'package:proyect1/pages/option_ans.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 252, 250, 1),

floatingActionButton: Padding(
  padding: const EdgeInsets.only(bottom: 40),
  child: FloatingActionButton(
    onPressed: () {
      Navigator.pushNamed(context, 'chat');
    },

    backgroundColor: const Color.fromRGBO(196, 211, 188, 1),

    child: const Icon(
      Icons.chat,
      color: Colors.white,
      size: 30,
    ),
  ),
),

floatingActionButtonLocation:
    FloatingActionButtonLocation.centerFloat,
      // 🔹 APPBAR PERSONALIZADO
      appBar: 
      PreferredSize(

  preferredSize: const Size.fromHeight(160), // 👈 altura externa
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: AppBar(
      
      toolbarHeight: 100, // 👈 altura
      elevation: 2,
shadowColor: Colors.black.withOpacity(0.3),
      backgroundColor: const Color.fromRGBO(196, 211, 188, 1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(60),
        ),
      ),

      //  LOGO
      // leading: Padding(
      //   padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
      //   child: Image.asset('logo5.png'),
      // ),

      //  TÍTULO
      centerTitle: true,
      title: const Padding(
        padding: EdgeInsets.only(top: 40),
        child: Text(
          "SATORI",
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // 🔹 MENÚ
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: PopupMenuButton<String>(
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
        ),
      ],
    ),
  ),
),
        
      

      
      
      
      
      
      
      // 🔹 CUERPO CON GRID
      body: Column(
  children: [
      
      SizedBox(height: 40),
      
      Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30),
  child: Text(
    'Selecciona como te sientes en este momento',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 41, 41, 41),
    ),
  ),
),
      SizedBox(height: 6),

      Divider(
        color: Colors.black,
        thickness: 1.5,   // grosor de la línea
        indent: 100,    // espacio a la izquierda
        endIndent: 100, // espacio a la derecha
      ),

    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              
              AnimatedMenuButton(
  imagePath: 'icons/aburrido.png',
  text: "Aburrimiento",
  screen: LoadingScreen(destino: const ActivacionRapida()),
),

AnimatedMenuButton(
  imagePath: 'icons/enfermo.png',
  text: "Ansiedad",
  screen: LoadingScreen(destino: const AnsiedadFlow()),
),

AnimatedMenuButton(
  imagePath: 'icons/nervioso.png',
  text: "Impulso",
  screen: LoadingScreen(destino: const  RedireccionCognitiva()),
),

AnimatedMenuButton(
  imagePath: 'icons/triste.png',
  text: "Tristeza",
  screen: LoadingScreen(destino: const TristezaFlow()),
),
              
            ],
          ),
          
        ),
        
      ),
      
    ),

      

      Divider(
        color: Colors.black,
        thickness: 1.5,   // grosor de la línea
        indent: 100,    // espacio a la izquierda
        endIndent: 100, // espacio a la derecha
      ),
      SizedBox(height: 6),
      Padding(
        
  padding: const EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 150),
  child: Text(
    '"Tu celular ya tiene suficiente batería, ahora tu cuida la tuya."',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 104, 104, 104),
    ),
  ),
),

    // 🔻 BOTON ABAJO
    // Padding(
      
    //   padding: const EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 80),
    //   child: BotonCounter(
    //     destino: const Pantalla1(), // cambia destino aquí
    //   ),
    // ),
  ],
),
      
    );
    
  }

  // 🔹 WIDGET REUTILIZABLE PARA BOTONES
  
  Widget buildMenuButton(
      BuildContext context, IconData icon, String text, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(233, 237, 227, 1),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: const Color.fromRGBO(117, 119, 114, 1)),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////
// 🔹 PANTALLAS DE EJEMPLO
//////////////////////////////////////////////////////////

class Pantalla1 extends StatelessWidget {
  const Pantalla1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Pantalla 1")),
    );
  }
}

class Pantalla2 extends StatelessWidget {
  const Pantalla2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Pantalla 2")),
    );
  }
}

class Pantalla3 extends StatelessWidget {
  const Pantalla3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Pantalla 3")),
    );
  }
}

class Pantalla4 extends StatelessWidget {
  const Pantalla4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Pantalla 4")),
    );
  }
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

    // Simula carga de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => widget.destino),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(196, 211, 188, 1), // 🔥 pantalla verde
      body: const Center(
        child: SpinKitWaveSpinner(
          color: Colors.white,
          size: 120.0,
      ),

      ),
    );
  }
}