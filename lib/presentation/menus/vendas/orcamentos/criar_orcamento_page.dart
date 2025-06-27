import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/core/util/buscar_produto_no_banco_de_dados.dart';
import 'package:manager_app/model/produto_model.dart';
import 'package:manager_app/widgets/datetime_textformfield_widget.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';

class CriarOrcamentoPage extends StatefulWidget {
  const CriarOrcamentoPage({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return CriarOrcamentoPage();
      },
    );
  }

  @override
  State<CriarOrcamentoPage> createState() => _CriarOrcamentoPageState();
}

class _CriarOrcamentoPageState extends State<CriarOrcamentoPage> {
  DateTime dataHoraOrcamento = DateTime.now();
  TextEditingController codigoOuDescricaoController = TextEditingController();

  void updateDataHora(DateTime novaDataHora) {
    setState(() {
      dataHoraOrcamento = novaDataHora;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
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
                      TextWidget.title('Criar Orçamento'),
                      const Spacer(),
                      CloseButton(),
                    ],
                  ),
                  TextWidget.small(
                    'OBS: Orçamentos não possuem forma de pagamento.',
                  ),
                  const SizedBoxWidget.md(),
                  DateTimeTextFormFieldWidget(
                    dataHora: dataHoraOrcamento,
                    updateDataHora: updateDataHora,
                  ),
                  const SizedBoxWidget.md(),
                  TextFormFieldWidget(
                    controller: TextEditingController(),
                    inputLabel: 'Cliente',
                  ),
                  const SizedBoxWidget.sm(),
                  Divider(),
                  const SizedBoxWidget.sm(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: codigoOuDescricaoController,
                          inputLabel: 'Busca por Descrição/Código',
                          icon: LucideIcons.packagePlus,
                        ),
                      ),
                      const SizedBoxWidget.xs(),
                      ElevatedButtonWidget(
                        height: 45,
                        isPrimary: false,
                        label: '  Adicionar Produto  ',
                        //icon: Icons.add,
                        onPressed: () async {
                          ProdutosModel? produto =
                              await BuscarProdutoNoBancoDeDados().buscar(
                                context,
                                codigoOuDescricaoController.text,
                              );

                          print(produto);
                        },
                      ),
                    ],
                  ),
                  const SizedBoxWidget.lg(),
                  ElevatedButtonWidget(
                    width: double.infinity,
                    height: 45,
                    label: 'Finalizar',
                    onPressed: () {},
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
