import 'package:flutter/material.dart';

class AnimatedMenuButton extends StatefulWidget {
  
  final String imagePath;
  final String text;
  final Widget screen;

  const AnimatedMenuButton({
    super.key,
    required this.imagePath,
    required this.text,
    required this.screen,
  });

  @override
  State<AnimatedMenuButton> createState() => _AnimatedMenuButtonState();
}

class _AnimatedMenuButtonState extends State<AnimatedMenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  late Animation<double> _translate;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // 🔹 Rotación MUY leve (en radianes)
    _rotation = Tween<double>(begin: -0.02, end: 0.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // 🔹 Movimiento vertical leve
    _translate = Tween<double>(begin: -3, end: 3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _translate.value),
          child: Transform.rotate(
            angle: _rotation.value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => widget.screen),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(233, 237, 227, 1),
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
              Image.asset(
  widget.imagePath,
  width: 70,
  height: 70,
  color: Color.fromRGBO(117, 119, 114, 1),
  fit: BoxFit.contain,
),
              const SizedBox(height: 14),
              Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}