import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/const/const.dart';
import 'package:manager_app/widgets/text_widget.dart';

class MenuRelatorios extends StatefulWidget {
  const MenuRelatorios({super.key});

  @override
  State<MenuRelatorios> createState() => _MenuRelatoriosState();
}

class _MenuRelatoriosState extends State<MenuRelatorios> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Const.tamanhoMenu,
      child: SubmenuButton(
        menuChildren: [
          MenuItemButton(
            onPressed: () {},
            child: TextWidget.normal('Vendas por Cliente'),
          ),
          MenuItemButton(
            onPressed: () {},
            child: TextWidget.normal('Contas à Receber'),
          ),
          MenuItemButton(
            onPressed: () {},
            child: TextWidget.normal('Contas à Pagar'),
          ),
          MenuItemButton(
            onPressed: () {},
            child: TextWidget.normal('Produtos mais Vendidos'),
          ),
          MenuItemButton(
            onPressed: () {},
            child: TextWidget.normal('Produtos menos Vendidos'),
          ),
          MenuItemButton(
            onPressed: () {},
            child: TextWidget.normal('Vendas por Forma de Pagamento'),
          ),
        ],
        child: TextWidget.normal(
          'Relatórios',
          color: AppColors.whiteColor,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
