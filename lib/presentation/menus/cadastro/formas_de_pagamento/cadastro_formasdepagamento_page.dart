import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';

class CadastroFormasDePagamentoPage extends StatefulWidget {
  const CadastroFormasDePagamentoPage({super.key});

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
                            TextWidget.title('Cadastro de Formas de Pagamento'),
                            const Spacer(),
                            CloseButton(),
                          ],
                        ),
                        TextWidget.small(
                          'Preencha o campo abaixo para cadastrar uma nova forma de pagamento.',
                        ),
                        const SizedBoxWidget.md(),
                        TextFormFieldWidget(
                          controller: TextEditingController(),
                          inputLabel: 'Descrição*',
                          icon: LucideIcons.walletCards,
                          suffixWidget: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextWidget.normal('À VISTA'),
                              Checkbox(value: true, onChanged: (valor) {}),
                            ],
                          ),
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
  State<CadastroFormasDePagamentoPage> createState() =>
      _CadastroFormasDePagamentoPageState();
}

class _CadastroFormasDePagamentoPageState
    extends State<CadastroFormasDePagamentoPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
