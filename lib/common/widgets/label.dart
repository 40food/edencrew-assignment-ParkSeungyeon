import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';

class AppLabel extends StatelessWidget {
  const AppLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: 19,
        fontWeight: AppTypography.bold,
      ),
    );
  }
}
