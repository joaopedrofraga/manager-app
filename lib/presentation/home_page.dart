import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/config/app_images.dart';
import 'package:manager_app/core/config/app_material.dart';
import 'package:manager_app/main.dart';
import 'package:manager_app/presentation/menus/cadastro/menu_cadastro.dart';
import 'package:manager_app/presentation/menus/configuracao/botao_configuracao.dart';
import 'package:manager_app/presentation/menus/financeiro/menu_financeiro.dart';
import 'package:manager_app/presentation/menus/relatorios/menu_relatorios.dart';
import 'package:manager_app/presentation/menus/utilitarios/menu_utilitarios.dart';
import 'package:manager_app/presentation/menus/vendas/menu_vendas.dart';
import 'package:manager_app/widgets/loading_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget.small(
          'Desenvolvido por João Fraga (github.com/joaopedrofraga)',
          color: AppColors.background,
        ),
      ),
      body: Stack(
        children: [
          ColoredBox(
            color: AppColors.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.primary,
                        padding: const EdgeInsets.only(right: 12),
                        child: Row(
                          children: [
                            MenuBar(
                              style: MenuStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  AppColors.primary,
                                ),
                                elevation: WidgetStatePropertyAll(0),
                              ),
                              children: [
                                BotaoConfiguracao(),
                                const VerticalDivider(),
                                MenuCadastro(),
                                MenuVendas(),
                                MenuFinanceiro(),
                                MenuUtilitarios(),
                                MenuRelatorios(),
                              ],
                            ),
                            const Spacer(),
                            TextWidget.title(
                              AppMaterial.title,
                              color: AppColors.whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Center(child: TextWidget.bold('Versão $versao')),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: SvgPicture.asset(AppImages.homePage),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
