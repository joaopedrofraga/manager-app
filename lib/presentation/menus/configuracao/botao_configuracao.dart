import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/presentation/menus/configuracao/page/configuracao_empresa_page.dart';

class BotaoConfiguracao extends StatefulWidget {
  const BotaoConfiguracao({super.key});

  @override
  State<BotaoConfiguracao> createState() => _BotaoConfiguracaoState();
}

class _BotaoConfiguracaoState extends State<BotaoConfiguracao> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => ConfiguracaoEmpresaPage.show(context),
      icon: Icon(LucideIcons.settings, size: 20, color: AppColors.whiteColor),
    );
  }
}
