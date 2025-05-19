import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';

class CadastroClientesPage extends StatefulWidget {
  const CadastroClientesPage({super.key});

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
                            TextWidget.title('Cadastro de Clientes'),
                            const Spacer(),
                            CloseButton(),
                          ],
                        ),
                        TextWidget.small(
                          'Preencha os campos abaixo para cadastrar um novo cliente.',
                        ),
                        const SizedBoxWidget.md(),
                        TextFormFieldWidget(
                          controller: TextEditingController(),
                          inputLabel: 'Nome do Cliente*',
                          icon: LucideIcons.contact,
                        ),
                        const SizedBoxWidget.sm(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: TextEditingController(),
                                inputLabel: 'CPF/CNPJ*',
                                icon: LucideIcons.idCard,
                              ),
                            ),
                            const SizedBoxWidget.sm(),
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: TextEditingController(),
                                inputLabel: 'Estado*',
                                icon: LucideIcons.mapPin,
                              ),
                            ),
                          ],
                        ),
                        const SizedBoxWidget.sm(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: TextEditingController(),
                                inputLabel: 'CEP*',
                                icon: LucideIcons.asterisk,
                              ),
                            ),
                            const SizedBoxWidget.sm(),
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: TextEditingController(),
                                inputLabel: 'Cidade*',
                                icon: LucideIcons.mapPinned,
                              ),
                            ),
                          ],
                        ),
                        const SizedBoxWidget.sm(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: TextEditingController(),
                                inputLabel: 'Bairro*',
                                icon: LucideIcons.building2,
                              ),
                            ),
                            const SizedBoxWidget.sm(),
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: TextEditingController(),
                                inputLabel: 'Endereço*',
                                icon: LucideIcons.locateFixed,
                              ),
                            ),
                          ],
                        ),
                        const SizedBoxWidget.sm(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: TextEditingController(),
                                inputLabel: 'Número*',
                                icon: LucideIcons.house,
                              ),
                            ),
                            const SizedBoxWidget.sm(),
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: TextEditingController(),
                                inputLabel: 'Complemento',
                                icon: LucideIcons.circleEllipsis,
                              ),
                            ),
                          ],
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
  State<CadastroClientesPage> createState() => _CadastroClientesPageState();
}

class _CadastroClientesPageState extends State<CadastroClientesPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
