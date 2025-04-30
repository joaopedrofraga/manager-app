import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/config/app_material.dart';
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
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: TextWidget.title(AppMaterial.title, color: AppColors.background),
      //   toolbarHeight: 50,
      //   backgroundColor: AppColors.primary.withValues(blue: 180),
      // ),
      body: ColoredBox(
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.group,
                                size: 20,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            const VerticalDivider(),
                            SubmenuButton(
                              menuChildren: [
                                MenuItemButton(
                                  onPressed: () {},
                                  child: TextWidget.normal(
                                    'Clientes/Fornecedores',
                                  ),
                                ),
                                MenuItemButton(
                                  onPressed: () {},
                                  child: TextWidget.normal('Produtos'),
                                ),
                                MenuItemButton(
                                  onPressed: () {},
                                  child: TextWidget.normal(
                                    'Formas de Pagamento',
                                  ),
                                ),
                              ],
                              child: TextWidget.normal(
                                'Cadastro',
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SubmenuButton(
                              menuChildren: [
                                SubmenuButton(
                                  menuChildren: [
                                    MenuItemButton(
                                      onPressed: () {},
                                      child: TextWidget.normal(
                                        'Criar Orçamento',
                                      ),
                                    ),
                                    MenuItemButton(
                                      onPressed: () {},
                                      child: TextWidget.normal(
                                        'Consultar Orçamento',
                                      ),
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
                                      child: TextWidget.normal(
                                        'Consultar Venda',
                                      ),
                                    ),
                                  ],
                                  child: TextWidget.normal('Vendas'),
                                ),
                              ],
                              child: TextWidget.normal(
                                'Vendas',
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SubmenuButton(
                              menuChildren: [
                                MenuItemButton(
                                  onPressed: () {},
                                  child: TextWidget.normal('Contas à Pagar'),
                                ),
                                MenuItemButton(
                                  onPressed: () {},
                                  child: TextWidget.normal('Contas à Receber'),
                                ),
                                MenuItemButton(
                                  onPressed: () {},
                                  child: TextWidget.normal('Fluxo de Caixa'),
                                ),
                              ],
                              child: TextWidget.normal(
                                'Financeiro',
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SubmenuButton(
                              menuChildren: [
                                MenuItemButton(
                                  onPressed: () {},
                                  child: TextWidget.normal('Ajuste de Estoque'),
                                ),
                                MenuItemButton(
                                  onPressed: () {},
                                  child: TextWidget.normal(
                                    'Copiar Script do Banco de Dados',
                                  ),
                                ),
                              ],
                              child: TextWidget.normal(
                                'Ferramentas',
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SubmenuButton(
                              menuChildren: [
                                MenuItemButton(
                                  onPressed: () {},
                                  child: TextWidget.normal('Ajuste de Estoque'),
                                ),
                                MenuItemButton(
                                  onPressed: () {},
                                  child: TextWidget.normal('Sobre'),
                                ),
                              ],
                              child: TextWidget.normal(
                                'Relatórios',
                                color: AppColors.whiteColor,
                              ),
                            ),
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
            Center(child: TextWidget.title('Projeto de Estudo')),
          ],
        ),
      ),
    );
  }
}
