import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  //---------------------------
  //         Main Heading
  //---------------------------

  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: .5,
  );

  //---------------------------
  //        Subheadings
  //---------------------------
  static const TextStyle heading2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  //---------------------------
  //        Button Labels
  //---------------------------
  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 1.0,
  );

  //---------------------------
  //       Input Field Text
  //---------------------------
  static const TextStyle inputText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  //---------------------------
  //       Input Field Hints
  //---------------------------
  static const TextStyle inputHint = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  //---------------------------
  //       Caption / Small
  //---------------------------
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}
