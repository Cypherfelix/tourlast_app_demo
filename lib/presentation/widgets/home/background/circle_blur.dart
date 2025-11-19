import 'package:flutter/material.dart';

class CircleBlur extends StatelessWidget {
  const CircleBlur({super.key, required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: const [BoxShadow(blurRadius: 40, color: Colors.white)],
      ),
    );
  }
}
