import 'dart:async';
import 'package:flutter/material.dart';

class BotonCounter extends StatefulWidget {
  final Widget destino;

  const BotonCounter({super.key, required this.destino});

  @override
  State<BotonCounter> createState() => _BotonCounterState();
}

class _BotonCounterState extends State<BotonCounter> {
  int segundosRestantes = 35;
  double progreso = 0.0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    iniciarContador();
  }

  void iniciarContador() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (segundosRestantes > 0) {
        setState(() {
          segundosRestantes--;
          progreso = 1 - (segundosRestantes / 35);
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool habilitado = segundosRestantes == 0;

    return GestureDetector(
      onTap: habilitado
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => widget.destino),
              );
            }
          : null,
      child: Container(
        height: 60,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          
          color: Colors.grey[300],
          border: Border.all(
    color: Color.fromRGBO(239, 240, 239, 1), // 👈 crema suave
    width: 6, // 👈 grosor
  ),
          
        ),
        child: Stack(
          children: [
            // 🔹 Barra de progreso
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 200 * progreso,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: const Color.fromRGBO(193, 207, 183, 1),
              ),
            ),

            // 🔹 Texto centrado
            Center(
              child: Text(
                habilitado
                    ? "Continuar"
                    : "Esperando ${segundosRestantes}s...",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(177, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}