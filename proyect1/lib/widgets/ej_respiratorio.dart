import 'package:flutter/material.dart';
import 'dart:async';

class EjRespiratorio extends StatefulWidget {
  const EjRespiratorio({super.key});

  @override
  State<EjRespiratorio> createState() => _EjRespiratorioState();
}

class _EjRespiratorioState extends State<EjRespiratorio>
    with SingleTickerProviderStateMixin {
      
  String texto = "Inhala";
  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 100, end: 180).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => texto = "Exhala");
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() => texto = "Inhala");
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          texto,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: _animation.value,
              height: _animation.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromRGBO(196, 211, 188, 1),
              ),
            );
          },
        ),
        
      ],
    );
  }
}