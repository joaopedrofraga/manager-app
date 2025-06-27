// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/model/produto_model.dart';
import 'package:manager_app/presentation/menus/cadastro/produtos/visualizar_alterar_produto_page.dart';
import 'package:manager_app/widgets/loading_widget.dart';
import 'package:manager_app/widgets/produto_list_tile_widget.dart';
import 'package:manager_app/widgets/quick_dialog_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';
import 'package:postgres/postgres.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ConsultaProdutosPage extends StatefulWidget {
  const ConsultaProdutosPage({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const ConsultaProdutosPage();
      },
    );
  }

  @override
  State<ConsultaProdutosPage> createState() => _ConsultaProdutosPageState();
}

class _ConsultaProdutosPageState extends State<ConsultaProdutosPage> {
  late Future<List<ProdutosModel>> produtosFuture;
  List<ProdutosModel> produtos = [];
  List<ProdutosModel> produtosFiltrados = [];
  TextEditingController filtroController = TextEditingController();
  Future<List<ProdutosModel>> buscarProdutos() async {
    //await Future.delayed(const Duration(seconds: 3));
    try {
      final db = await DbService().connection;
      final resultadosQuery = await db.execute(
        'SELECT * FROM produtos WHERE ativo = true ORDER BY descricao, codigo',
      );
      return resultadosQuery.map((row) {
        return ProdutosModel.fromMap(row.toColumnMap());
      }).toList();
    } catch (e) {
      throw Exception('$e');
    }
  }

  void filtrarProdutos(String texto) {
    setState(() {
      if (texto.isEmpty) {
        produtosFiltrados = produtos;
      } else {
        produtosFiltrados =
            produtos.where((produto) {
              final descricao = produto.descricao?.toLowerCase() ?? '';
              final codigo = produto.codigo?.toLowerCase() ?? '';
              final textoBusca = texto.toLowerCase();

              return descricao.contains(textoBusca) ||
                  codigo.contains(textoBusca);
            }).toList();
      }
    });
  }

  void reativarCadastro() {
    TextEditingController codigoController = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                TextWidget.title('Reativar Produto'),
                const Spacer(),
                const CloseButton(),
              ],
            ),
            content: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormFieldWidget(
                    controller: codigoController,
                    inputLabel: 'Insira o código do produto',
                    icon: LucideIcons.qrCode,
                    maxLength: 50,
                  ),
                  const SizedBoxWidget.lg(),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        try {
                          final db = await DbService().connection;
                          await db.execute(
                            Sql.named(
                              'UPDATE produtos SET ativo = true WHERE codigo = @codigo',
                            ),
                            parameters: {'codigo': codigoController.text},
                          );
                          Navigator.pop(context);
                          //Navigator.pop(context);

                          await QuickDialogWidget().sucessoMsg(
                            context: context,
                            texto: 'Produto reativado com sucesso.',
                            textoBotao: 'Finalizar',
                          );
                        } catch (e) {
                          await QuickDialogWidget().erroMsg(
                            context: context,
                            texto: 'Erro ao reativar o Produto: $e',
                            textoBotao: 'Voltar',
                          );
                        }
                      },
                      child: TextWidget.bold(
                        'Confirmar',
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  void initState() {
    produtosFuture = buscarProdutos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.getWidth * 0.25 + 300,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget.title('Consulta de Produtos'),
                      const Spacer(),
                      IconButton(
                        onPressed: () => reativarCadastro(),
                        tooltip: 'Reativar Produto',
                        icon: Icon(Icons.restore_from_trash),
                      ),
                      const SizedBoxWidget.xs(),
                      CloseButton(),
                    ],
                  ),
                  FutureBuilder(
                    future: produtosFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingWidget();
                      } else if (snapshot.hasError) {
                        Navigator.of(context).pop();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          QuickAlert.show(
                            context: context,
                            width: 300,
                            confirmBtnText: 'Voltar',
                            confirmBtnColor: AppColors.primary,
                            type: QuickAlertType.error,
                            title: 'ERRO!',
                            text:
                                'Erro ao consultar os produtos: ${snapshot.error.toString()}',
                          );
                        });
                        return SizedBox.shrink();
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/empty.svg',
                                  width: 140,
                                ),
                                const SizedBoxWidget.sm(),
                                TextWidget.normal('Nenhum produto encontrado.'),
                              ],
                            ),
                          ),
                        );
                      } else {
                        if (produtos.isEmpty) {
                          produtos = snapshot.data!;
                          produtosFiltrados = produtos;
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget.small(
                              'DICA: Clique no produto desejado para ver mais detalhes ou editar/excluir.',
                            ),
                            const SizedBoxWidget.md(),
                            TextFormFieldWidget(
                              icon: LucideIcons.search,
                              controller: filtroController,
                              inputLabel:
                                  'Buscar por descrição ou código do produto',
                              onChanged: filtrarProdutos,
                            ),
                            const SizedBoxWidget.xs(),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: context.getHeight * 0.7,
                              ),
                              child: ListView.builder(
                                itemCount: produtosFiltrados.length,
                                itemBuilder: (context, index) {
                                  final produto = produtosFiltrados[index];
                                  return ProdutoListTileWidget(
                                    produto: produto,
                                    onTap:
                                        () => VisualizarAlterarProdutoPage.show(
                                          context,
                                          produto,
                                        ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
