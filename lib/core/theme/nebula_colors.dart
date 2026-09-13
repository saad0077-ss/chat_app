import 'package:flutter/material.dart';

class NebulaColors {
  // Midnight Obsidian Background
  static const Color background = Color(0xFF090A10);
  static const Color surface = Color(0xFF121524);
  static const Color surfaceElevated = Color(0xFF1A1E33);
  static const Color glassBorder = Color(0x26FFFFFF);

  // brand Neon Gradient
  static const Color electricViolet = Color(0xFF7C3AED);
  static const Color deepIndigo = Color(0xFF4F46E5);
  static const Color neonCyan = Color(0xFF06B6D4);
  static const Color rosePink = Color(0xFFF43F5E);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [electricViolet, deepIndigo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient senderBubbleGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Receiver Bubble Gradient
  static const Color receiverBubble = Color(0xFF16192B);

  //Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Status Indicators
  static const Color onlineGlow = Color(0xFF10B981);
  static const Color pendingSync = Color(0xFFF59E0B);
  static const Color synced = Color(0xFF38BDF8);
}
