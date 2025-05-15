import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/widgets/text_widget.dart';

class MenuCadastro extends StatefulWidget {
  const MenuCadastro({super.key});

  @override
  State<MenuCadastro> createState() => _MenuCadastroState();
}

class _MenuCadastroState extends State<MenuCadastro> {
  @override
  Widget build(BuildContext context) {
    return SubmenuButton(
      menuChildren: [
        MenuItemButton(
          onPressed: () {},
          child: TextWidget.normal('Clientes/Fornecedores'),
        ),
        MenuItemButton(onPressed: () {}, child: TextWidget.normal('Produtos')),
        MenuItemButton(
          onPressed: () {},
          child: TextWidget.normal('Formas de Pagamento'),
        ),
      ],
      child: TextWidget.normal('Cadastro', color: AppColors.whiteColor),
    );
  }
}
