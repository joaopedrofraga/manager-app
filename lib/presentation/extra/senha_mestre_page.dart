// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/core/global/global.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/quick_dialog_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';

class SenhaMestrePage extends StatefulWidget {
  const SenhaMestrePage({super.key});

  static Future<bool?> validar(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const SenhaMestrePage(),
    );
  }

  @override
  State<SenhaMestrePage> createState() => _SenhaMestrePageState();
}

class _SenhaMestrePageState extends State<SenhaMestrePage> {
  TextEditingController senhaController = TextEditingController();

  @override
  void dispose() {
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.getWidth * 0.2 + 50),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget.title('Área Restrita'),
                      const Spacer(),
                      CloseButton(),
                    ],
                  ),
                  TextWidget.small('Insira a senha mestre para prosseguir.'),
                  const SizedBoxWidget.sm(),
                  TextFormFieldWidget(
                    controller: senhaController,
                    inputLabel: 'Senha',
                    icon: LucideIcons.lockKeyhole,
                    isPassword: true,
                    maxLength: 100,
                  ),
                  const SizedBoxWidget.lg(),
                  ElevatedButtonWidget(
                    label: 'Validar',
                    width: double.infinity,
                    height: 40,
                    onPressed: () async {
                      final senhaMestre = await Global().getSenhaMestre();
                      if (senhaController.text == senhaMestre) {
                        Navigator.pop(context, true);
                      } else {
                        await QuickDialogWidget().erroMsg(
                          context: context,
                          texto: 'A senha inserida é inválida.',
                          textoBotao: 'Voltar',
                        );
                        Navigator.pop(context, false);
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
