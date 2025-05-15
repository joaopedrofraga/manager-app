import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/widgets/text_widget.dart';

class MenuVendas extends StatefulWidget {
  const MenuVendas({super.key});

  @override
  State<MenuVendas> createState() => _MenuVendasState();
}

class _MenuVendasState extends State<MenuVendas> {
  @override
  Widget build(BuildContext context) {
    return SubmenuButton(
      menuChildren: [
        SubmenuButton(
          menuChildren: [
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Criar Orçamento'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Consultar Orçamento'),
            ),
          ],
          child: TextWidget.normal('Orçamentos'),
        ),
        SubmenuButton(
          menuChildren: [
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Criar Venda'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Consultar Venda'),
            ),
          ],
          child: TextWidget.normal('Vendas'),
        ),
      ],
      child: TextWidget.normal('Vendas', color: AppColors.whiteColor),
    );
  }
}
