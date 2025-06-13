import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/const/const.dart';
import 'package:manager_app/presentation/menus/cadastro/clientes_fornecedores/cadastro_clientes_fornecedores_page.dart';
import 'package:manager_app/presentation/menus/cadastro/clientes_fornecedores/consulta_clientes_fornecedores_page.dart';
import 'package:manager_app/presentation/menus/cadastro/formas_de_pagamento/cadastro_formasdepagamento_page.dart';
import 'package:manager_app/presentation/menus/cadastro/produtos/cadastro_produtos_page.dart';
import 'package:manager_app/widgets/text_widget.dart';

class MenuCadastro extends StatefulWidget {
  const MenuCadastro({super.key});

  @override
  State<MenuCadastro> createState() => _MenuCadastroState();
}

class _MenuCadastroState extends State<MenuCadastro> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Const.tamanhoMenu,
      child: SubmenuButton(
        menuChildren: [
          SubmenuButton(
            menuChildren: [
              MenuItemButton(
                onPressed: () => CadastroClientesFornecedoresPage.show(context),
                child: TextWidget.normal('Cadastrar Cliente/Fornecedor'),
              ),
              MenuItemButton(
                onPressed: () => ConsultaClientesFornecedoresPage.show(context),
                child: TextWidget.normal('Consultar Clientes/Fornecedores'),
              ),
            ],
            child: TextWidget.normal('Clientes/Fornecedores'),
          ),
          SubmenuButton(
            menuChildren: [
              MenuItemButton(
                onPressed: () => CadastroProdutosPage.show(context),
                child: TextWidget.normal('Cadastrar Produto'),
              ),
              MenuItemButton(
                onPressed: () {},
                child: TextWidget.normal('Consultar Produtos'),
              ),
            ],
            child: TextWidget.normal('Produtos'),
          ),
          SubmenuButton(
            menuChildren: [
              MenuItemButton(
                onPressed: () => CadastroFormasDePagamentoPage.show(context),
                child: TextWidget.normal('Cadastrar Forma de Pagamento'),
              ),
              MenuItemButton(
                onPressed: () {},
                child: TextWidget.normal('Consultar Formas de Pagamento'),
              ),
            ],
            child: TextWidget.normal('Formas de Pagamento'),
          ),
        ],
        child: TextWidget.normal(
          'Cadastro',
          color: AppColors.whiteColor,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
