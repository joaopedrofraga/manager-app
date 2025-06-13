// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/model/cliente_fornecedor_model.dart';
import 'package:manager_app/widgets/loading_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
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
  Future<List<ClienteFornecedorModel>?> buscarClientesFornecedores() async {
    //await Future.delayed(const Duration(seconds: 3));
    try {
      final db = await DbService().connection;
      final resultadosQuery = await db.execute(
        'SELECT * FROM clientes_fornecedores WHERE ativo = true',
      );
      return resultadosQuery.map((row) {
        return ClienteFornecedorModel.fromMap(row.toColumnMap());
      }).toList();
    } catch (e) {
      throw Exception('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.getWidth * 0.2 + 300),
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
                  Center(
                    child: FutureBuilder(
                      future: buscarClientesFornecedores(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Padding(
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
                          );
                        } else {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: context.getHeight * 0.5,
                            ),
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final clienteFornecedor = snapshot.data![index];
                                return ListTile(
                                  title: TextWidget.normal(
                                    clienteFornecedor.nome!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hoverColor: AppColors.primary.withOpacity(
                                    0.1,
                                  ),
                                  onTap: () {},
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
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
