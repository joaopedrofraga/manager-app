import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/global/global.dart';
import 'package:manager_app/presentation/menus/configuracao/page/configuracao_empresa_page.dart';
import 'package:manager_app/widgets/text_widget.dart';

enum _MenuOptions { configuracaoEmpresa, sobre, sair }

class BotaoConfiguracao extends StatelessWidget {
  const BotaoConfiguracao({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuOptions>(
      icon: Icon(LucideIcons.settings, size: 22, color: AppColors.whiteColor),
      tooltip: 'Configurações',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColors.background,
      elevation: 4,
      offset: const Offset(0, 40),
      onSelected: (option) {
        switch (option) {
          case _MenuOptions.configuracaoEmpresa:
            ConfiguracaoEmpresaPage.show(context);
            break;
          case _MenuOptions.sobre:
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(title: TextWidget.normal('Teste')),
            );
            break;
          case _MenuOptions.sair:
            Global().clearUsuarioAtual();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
            break;
        }
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: _MenuOptions.configuracaoEmpresa,
              child: Row(
                children: [
                  Icon(
                    LucideIcons.building2,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  const Text('Configuração da Empresa'),
                ],
              ),
            ),
            PopupMenuItem(
              value: _MenuOptions.sobre,
              child: Row(
                children: [
                  Icon(LucideIcons.info, size: 20, color: AppColors.primary),
                  const SizedBox(width: 12),
                  const Text('Sobre o App'),
                ],
              ),
            ),
            // Divisória para separar visualmente as ações
            const PopupMenuDivider(),
            PopupMenuItem(
              value: _MenuOptions.sair,
              child: Row(
                children: [
                  Icon(
                    LucideIcons.logOut,
                    size: 20,
                    color: Colors.red.shade600,
                  ),
                  const SizedBox(width: 12),
                  Text('Sair', style: TextStyle(color: Colors.red.shade600)),
                ],
              ),
            ),
          ],
    );
  }
}
