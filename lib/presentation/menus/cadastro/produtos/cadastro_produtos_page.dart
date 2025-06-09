import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';

class CadastroProdutosPage extends StatefulWidget {
  const CadastroProdutosPage({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => Scaffold(
            backgroundColor: Colors.transparent,
            body: Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: context.getWidth * 0.2 + 300,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWidget.title('Cadastro de Produtos'),
                            const Spacer(),
                            CloseButton(),
                          ],
                        ),
                        TextWidget.small(
                          'Preencha os campos abaixo para cadastrar um novo produto.',
                        ),
                        const SizedBoxWidget.md(),
                        TextFormFieldWidget(
                          controller: TextEditingController(),
                          inputLabel: 'Código do Produto*',
                          icon: LucideIcons.qrCode,
                        ),
                        const SizedBoxWidget.sm(),
                        TextFormFieldWidget(
                          controller: TextEditingController(),
                          inputLabel: 'Nome do Produto*',
                          icon: LucideIcons.shoppingBasket,
                        ),
                        const SizedBoxWidget.sm(),
                        TextFormFieldWidget(
                          controller: TextEditingController(),
                          inputLabel: 'Valor de Custo',
                          icon: LucideIcons.coins,
                        ),
                        const SizedBoxWidget.sm(),
                        TextFormFieldWidget(
                          controller: TextEditingController(),
                          inputLabel: 'Valor de Venda*',
                          icon: LucideIcons.handCoins,
                        ),
                        const SizedBoxWidget.sm(),
                        TextFormFieldWidget(
                          controller: TextEditingController(),
                          inputLabel: 'Estoque*',
                          icon: LucideIcons.box,
                        ),
                        const SizedBoxWidget.sm(),
                        TextFormFieldWidget(
                          controller: TextEditingController(),
                          inputLabel: 'Observações',
                          maxLines: 3,
                          icon: LucideIcons.telescope,
                        ),
                        const SizedBoxWidget.lg(),
                        ElevatedButtonWidget(
                          label: 'Cadastrar',
                          width: double.infinity,
                          height: 40,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }

  @override
  State<CadastroProdutosPage> createState() => _CadastroProdutosPageState();
}

class _CadastroProdutosPageState extends State<CadastroProdutosPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
