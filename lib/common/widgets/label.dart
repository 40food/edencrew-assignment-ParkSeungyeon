import 'package:flutter/material.dart';

import '../../theme/theme.dart';

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
