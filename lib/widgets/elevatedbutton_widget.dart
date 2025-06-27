import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/widgets/text_widget.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isLoading;
  final String? loadingMessage;
  final double? width;
  final double? height;
  final IconData? icon;
  final Color? backgroundColor;

  const ElevatedButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
    this.loadingMessage,
    this.width,
    this.height,
    this.icon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final child =
        isLoading
            ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 8),
                TextWidget.normal(
                  loadingMessage ?? 'Carregando...',
                  color:
                      isPrimary ? AppColors.whiteColor : AppColors.blackColor,
                ),
              ],
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18),
                  const SizedBox(width: 6),
                ],
                TextWidget.normal(label, color: AppColors.background),
              ],
            );

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor:
              backgroundColor ??
              (isPrimary ? AppColors.primary : AppColors.secundary),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: child,
      ),
    );
  }
}
