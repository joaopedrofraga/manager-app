// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/model/cliente_fornecedor_model.dart';
import 'package:manager_app/presentation/menus/cadastro/clientes_fornecedores/visualizar_alterar_cliente_fornecedor_page.dart';
import 'package:manager_app/widgets/loading_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ConsultaClientesFornecedoresPage extends StatefulWidget {
  const ConsultaClientesFornecedoresPage({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const ConsultaClientesFornecedoresPage();
      },
    );
  }

  @override
  State<ConsultaClientesFornecedoresPage> createState() =>
      _ConsultaClientesFornecedoresPageState();
}

class _ConsultaClientesFornecedoresPageState
    extends State<ConsultaClientesFornecedoresPage> {
  late Future<List<ClienteFornecedorModel>> clientesFornecedoresFuture;
  List<ClienteFornecedorModel> clientesFornecedores = [];
  List<ClienteFornecedorModel> clientesFornecedoresFiltrados = [];
  TextEditingController filtroController = TextEditingController();
  Future<List<ClienteFornecedorModel>> buscarClientesFornecedores() async {
    //await Future.delayed(const Duration(seconds: 3));
    try {
      final db = await DbService().connection;
      final resultadosQuery = await db.execute(
        'SELECT * FROM clientes_fornecedores WHERE ativo = true ORDER BY nome, fantasia',
      );
      return resultadosQuery.map((row) {
        return ClienteFornecedorModel.fromMap(row.toColumnMap());
      }).toList();
    } catch (e) {
      throw Exception('$e');
    }
  }

  void filtrarClientesFornecedores(String texto) {
    setState(() {
      if (texto.isEmpty) {
        clientesFornecedoresFiltrados = clientesFornecedores;
      } else {
        clientesFornecedoresFiltrados =
            clientesFornecedores.where((cliente) {
              final nomeFantasia =
                  '${cliente.nome ?? ''} ${cliente.fantasia ?? ''}'
                      .toLowerCase();
              final cpfCnpj = cliente.cpfCnpj?.toLowerCase() ?? '';
              final textoBusca = texto.toLowerCase();

              return nomeFantasia.contains(textoBusca) ||
                  cpfCnpj
                      .replaceAll('.', '')
                      .replaceAll('-', '')
                      .replaceAll('/', '')
                      .contains(textoBusca);
            }).toList();
      }
    });
  }

  @override
  void initState() {
    clientesFornecedoresFuture = buscarClientesFornecedores();
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
                      TextWidget.title('Consulta de Cadastros'),
                      const Spacer(),
                      CloseButton(),
                    ],
                  ),
                  FutureBuilder(
                    future: clientesFornecedoresFuture,
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
                                'Erro ao consultar os clientes e fornecedores: ${snapshot.error.toString()}',
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
                                TextWidget.normal(
                                  'Nenhum cliente ou fornecedor encontrado.',
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        if (clientesFornecedores.isEmpty) {
                          clientesFornecedores = snapshot.data!;
                          clientesFornecedoresFiltrados = clientesFornecedores;
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget.small(
                              'DICA: Clique no cadastro desejado para ver mais detalhes ou editar/excluir.',
                            ),
                            const SizedBoxWidget.md(),
                            TextFormFieldWidget(
                              icon: LucideIcons.search,
                              controller: filtroController,
                              inputLabel:
                                  'Buscar por nome/fantasia ou CPF/CNPJ',
                              onChanged: filtrarClientesFornecedores,
                            ),
                            const SizedBoxWidget.xs(),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: context.getHeight * 0.7,
                              ),
                              child: ListView.builder(
                                itemCount: clientesFornecedoresFiltrados.length,
                                itemBuilder: (context, index) {
                                  final clienteFornecedor =
                                      clientesFornecedoresFiltrados[index];
                                  return ListTile(
                                    title: TextWidget.bold(
                                      '${clienteFornecedor.nome!} ${clienteFornecedor.fantasia != '' ? '(${clienteFornecedor.fantasia!})' : ''}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: TextWidget.small(
                                      clienteFornecedor.getEnderecoFormatado(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: TextWidget.normal(
                                      clienteFornecedor.cpfCnpj!,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hoverColor: AppColors.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                    onTap:
                                        () =>
                                            VisualizarAlterarClienteFornecedoresPage.show(
                                              context,
                                              clienteFornecedor,
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
