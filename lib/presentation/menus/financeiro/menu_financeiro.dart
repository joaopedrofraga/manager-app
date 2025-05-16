import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/widgets/text_widget.dart';

class MenuFinanceiro extends StatefulWidget {
  const MenuFinanceiro({super.key});

  @override
  State<MenuFinanceiro> createState() => _MenuFinanceiroState();
}

class _MenuFinanceiroState extends State<MenuFinanceiro> {
  @override
  Widget build(BuildContext context) {
    return SubmenuButton(
      menuChildren: [
        SubmenuButton(
          menuChildren: [
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Lançar Conta'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Baixar Conta'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Alterar Conta'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Estornar Conta'),
            ),
          ],
          child: TextWidget.normal('Contas à Pagar'),
        ),
        SubmenuButton(
          menuChildren: [
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Lançar Conta'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Baixar Conta'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Alterar Conta'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Estornar Conta'),
            ),
          ],
          child: TextWidget.normal('Contas à Receber'),
        ),
        SubmenuButton(
          menuChildren: [
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Consultar Caixa'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: TextWidget.normal('Lançar Valor'),
            ),
          ],
          child: TextWidget.normal('Fluxo de Caixa'),
        ),
      ],
      child: TextWidget.normal('Financeiro', color: AppColors.whiteColor),
    );
  }
}
