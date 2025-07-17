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

class AlterarSenhaMestrePage extends StatefulWidget {
  const AlterarSenhaMestrePage({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const AlterarSenhaMestrePage(),
    );
  }

  @override
  State<AlterarSenhaMestrePage> createState() => _AlterarSenhaMestrePageState();
}

class _AlterarSenhaMestrePageState extends State<AlterarSenhaMestrePage> {
  TextEditingController senhaController = TextEditingController();
  TextEditingController novaSenhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();

  @override
  void dispose() {
    senhaController.dispose();
    novaSenhaController.dispose();
    confirmarSenhaController.dispose();
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
                      TextWidget.title('Alterar Senha Mestre'),
                      const Spacer(),
                      CloseButton(),
                    ],
                  ),
                  TextWidget.small(
                    'Insira a senha mestre atual para alterá-la.',
                  ),
                  const SizedBoxWidget.sm(),
                  TextFormFieldWidget(
                    controller: senhaController,
                    inputLabel: 'Senha Atual',
                    icon: LucideIcons.lockKeyhole,
                    isPassword: true,
                    maxLength: 100,
                  ),
                  const SizedBoxWidget.md(),
                  TextFormFieldWidget(
                    controller: novaSenhaController,
                    inputLabel: 'Nova Senha Mestre',
                    icon: LucideIcons.rotateCcwKey,
                    isPassword: true,
                    maxLength: 100,
                  ),
                  const SizedBoxWidget.md(),
                  TextFormFieldWidget(
                    controller: confirmarSenhaController,
                    inputLabel: 'CONFIRME a Nova Senha Mestre',
                    icon: LucideIcons.rotateCcwKey,
                    isPassword: true,
                    maxLength: 100,
                  ),
                  const SizedBoxWidget.lg(),
                  ElevatedButtonWidget(
                    label: 'Alterar',
                    width: double.infinity,
                    height: 40,
                    onPressed: () async {
                      final senhaMestre = await Global().getSenhaMestre();
                      if (senhaController.text != senhaMestre) {
                        await QuickDialogWidget().erroMsg(
                          context: context,
                          texto: 'A senha mestre inserida é inválida.',
                          textoBotao: 'Voltar',
                        );
                        return;
                      }
                      if (novaSenhaController.text.isEmpty ||
                          confirmarSenhaController.text.isEmpty) {
                        await QuickDialogWidget().erroMsg(
                          context: context,
                          texto: 'Por favor, preencha todos os campos.',
                          textoBotao: 'Voltar',
                        );
                        return;
                      }
                      if (novaSenhaController.text !=
                          confirmarSenhaController.text) {
                        await QuickDialogWidget().erroMsg(
                          context: context,
                          texto: 'As senhas inseridas não coincidem.',
                          textoBotao: 'Voltar',
                        );
                        return;
                      }
                      try {
                        await Global().setSenhaMestre(novaSenhaController.text);
                        await QuickDialogWidget().sucessoMsg(
                          context: context,
                          texto: 'Senha mestre alterada com sucesso.',
                          textoBotao: 'OK',
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        await QuickDialogWidget().erroMsg(
                          context: context,
                          texto: 'Erro ao alterar a senha mestre: $e',
                          textoBotao: 'Voltar',
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
