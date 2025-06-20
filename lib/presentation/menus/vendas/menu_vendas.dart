import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/const/const.dart';
import 'package:manager_app/presentation/menus/vendas/orcamentos/criar_orcamento_page.dart';
import 'package:manager_app/widgets/text_widget.dart';

class MenuVendas extends StatefulWidget {
  const MenuVendas({super.key});

  @override
  State<MenuVendas> createState() => _MenuVendasState();
}

class _MenuVendasState extends State<MenuVendas> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Const.tamanhoMenu,
      child: SubmenuButton(
        menuChildren: [
          SubmenuButton(
            menuChildren: [
              MenuItemButton(
                onPressed: () => CriarOrcamentoPage.show(context),
                child: TextWidget.normal('Criar Orçamento'),
              ),
              MenuItemButton(
                onPressed: () {},
                child: TextWidget.normal('Consultar Orçamentos'),
              ),
            ],
            child: TextWidget.normal('Orçamentos'),
          ),
          SubmenuButton(
            menuChildren: [
              MenuItemButton(
                onPressed: () {},
                child: TextWidget.normal('Gerar Venda'),
              ),
              MenuItemButton(
                onPressed: () {},
                child: TextWidget.normal('Consultar Vendas'),
              ),
            ],
            child: TextWidget.normal('Vendas'),
          ),
        ],
        child: TextWidget.normal(
          'Vendas',
          color: AppColors.whiteColor,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
