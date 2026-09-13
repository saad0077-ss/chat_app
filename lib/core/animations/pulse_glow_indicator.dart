import 'package:chat_app/core/theme/nebula_colors.dart';
import 'package:flutter/material.dart';

class PulseGlowIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const PulseGlowIndicator({
    super.key,
    this.size = 10,
    this.color = NebulaColors.onlineGlow,
  });

  @override
  State<PulseGlowIndicator> createState() => _PulseGlowIndicatorState();
}

class _PulseGlowIndicatorState extends State<PulseGlowIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
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
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(
                  0.4 + (_controller.value * 0.4),
                ),
                blurRadius: 4 + (_controller.value * 0.4),
                spreadRadius: 1 + (_controller.value * 2),
              ),
            ],
          ),
        );
      },
    );
  }
}
