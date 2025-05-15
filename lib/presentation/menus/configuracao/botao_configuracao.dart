import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';

class BotaoConfiguracao extends StatefulWidget {
  const BotaoConfiguracao({super.key});

  @override
  State<BotaoConfiguracao> createState() => _BotaoConfiguracaoState();
}

class _BotaoConfiguracaoState extends State<BotaoConfiguracao> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.group, size: 20, color: AppColors.whiteColor),
    );
  }
}
