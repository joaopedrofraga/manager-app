import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/const/const.dart';
import 'package:manager_app/widgets/text_widget.dart';

class MenuUtilitarios extends StatefulWidget {
  const MenuUtilitarios({super.key});

  @override
  State<MenuUtilitarios> createState() => _MenuUtilitariosState();
}

class _MenuUtilitariosState extends State<MenuUtilitarios> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Const.tamanhoMenu,
      child: SubmenuButton(
        menuChildren: [
          MenuItemButton(
            onPressed: () {},
            child: TextWidget.normal('Ajuste de Estoque'),
          ),
          MenuItemButton(
            onPressed: () {},
            child: TextWidget.normal('Copiar Script do Banco de Dados'),
          ),
        ],
        child: TextWidget.normal(
          'Utilitários',
          color: AppColors.whiteColor,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
