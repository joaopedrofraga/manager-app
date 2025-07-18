import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';

class IconButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final String tooltip;
  const IconButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(),
      tooltip: tooltip,
      icon: Icon(icon, size: 30),
      style: IconButton.styleFrom(
        side: BorderSide(color: AppColors.primary, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
      ),
    );
  }
}
