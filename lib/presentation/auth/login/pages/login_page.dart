import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/config/app_images.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Container(
            height: double.infinity,
            width: context.getWidth / 4 + 150,
            color: AppColors.primary,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.getWidth / 3),
            child: SvgPicture.asset(AppImages.loginImage),
          ),
        ],
      ),
    );
  }
}
