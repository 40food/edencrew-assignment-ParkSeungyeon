import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';

class AppSnackBar extends SnackBar {
  AppSnackBar({
    super.key,
    required String message,
    required Widget icon,
    required AppColors colors,
    required AppDimens dimens,
  }) : super(
         backgroundColor: Colors.transparent,
         elevation: 0,
         content: Container(
           padding: EdgeInsets.symmetric(
             horizontal: dimens.space4,
             vertical: dimens.space3,
           ),
           decoration: BoxDecoration(
             color: colors.surfaceOverlay,
             borderRadius: BorderRadius.circular(dimens.radiusLg),
           ),
           child: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
               icon,
               SizedBox(width: dimens.space2),
               Text(
                 message,
                 style: TextStyle(
                   color: colors.textPrimary,
                   fontSize: 13,
                   fontWeight: AppTypography.bold,
                 ),
               ),
             ],
           ),
         ),
       );

  static void show(
    BuildContext context, {
    required String message,
    required Widget icon,
    required AppColors colors,
    required AppDimens dimens,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      AppSnackBar(message: message, icon: icon, colors: colors, dimens: dimens),
    );
  }
}
