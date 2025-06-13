import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manager_app/core/config/app_images.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppImages.loadingImage, width: 140),
            const SizedBoxWidget.sm(),
            SizedBox(
              width: 140,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBoxWidget.xxs(),
            TextWidget.normal('Carregando...'),
          ],
        ),
      ),
    );
  }
}
