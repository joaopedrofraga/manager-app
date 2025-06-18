// ignore_for_file: use_build_context_synchronously

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';
import 'package:postgres/postgres.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class CadastroFormasDePagamentoPage extends StatefulWidget {
  const CadastroFormasDePagamentoPage({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const CadastroFormasDePagamentoPage();
      },
    );
  }

  @override
  State<CadastroFormasDePagamentoPage> createState() =>
      _CadastroFormasDePagamentoPageState();
}

class _CadastroFormasDePagamentoPageState
    extends State<CadastroFormasDePagamentoPage> {
  final TextEditingController descricaoTEC = TextEditingController();
  bool aVista = true;

  @override
  void dispose() {
    descricaoTEC.dispose();
    super.dispose();
  }

  bool validarCamposPreenchidos() {
    return descricaoTEC.text.isEmpty;
  }

  Future<void> cadastrarFormaDePagamento() async {
    try {
      final db = await DbService().connection;
      await db.execute(
        Sql.named(
          'INSERT INTO formas_pagamento (descricao, a_vista) VALUES (@descricao, @aVista)',
        ),
        parameters: {'descricao': descricaoTEC.text, 'aVista': aVista},
      );
    } catch (e) {
      if (e is UniqueViolationException) {
        if (e.code == '23505') {
          QuickAlert.show(
            context: context,
            width: 300,
            confirmBtnText: 'Voltar ao Cadastro',
            confirmBtnColor: AppColors.primary,
            type: QuickAlertType.error,
            title: 'ERRO!',
            text: 'Forma de pagamento já cadastrada no sistema.',
          );
          return;
        }
      }
      QuickAlert.show(
        context: context,
        width: 300,
        confirmBtnText: 'Voltar ao Cadastro',
        confirmBtnColor: AppColors.primary,
        type: QuickAlertType.error,
        title: 'ERRO!',
        text: 'Erro ao cadastrar forma de pagamento: $e',
      );
      return;
    }
    await QuickAlert.show(
      context: context,
      width: 300,
      confirmBtnText: 'Finalizar',
      confirmBtnColor: AppColors.primary,
      type: QuickAlertType.success,
      title: 'SUCESSO!',
      text: 'Forma de pagamento cadastrada no sistema com sucesso.',
    );
    Navigator.pop(context);
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
                      TextWidget.title('Cadastro de Formas de Pagamento'),
                      const Spacer(),
                      CloseButton(),
                    ],
                  ),
                  TextWidget.small(
                    'Preencha o campo abaixo para cadastrar uma nova forma de pagamento.',
                  ),
                  const SizedBoxWidget.sm(),
                  TextFormFieldWidget(
                    controller: descricaoTEC,
                    inputLabel: 'Descrição*',
                    icon: LucideIcons.walletCards,
                    maxLength: 100,
                  ),
                  const SizedBoxWidget.sm(),
                  TextWidget.small(
                    'Selecione a modalidade da nova forma de pagamento:',
                  ),
                  const SizedBoxWidget.xxxs(),
                  AnimatedToggleSwitch.dual(
                    current: aVista,
                    first: true,
                    second: false,
                    spacing: double.infinity,
                    height: 35,
                    indicatorSize: Size(
                      (context.getWidth * 0.2 + 300) / 2,
                      double.infinity,
                    ),
                    indicatorTransition: ForegroundIndicatorTransition.fading(),
                    style: ToggleStyle(
                      borderColor: aVista ? AppColors.primary : null,
                      indicatorColor: aVista ? AppColors.primary : null,
                      borderRadius: BorderRadius.circular(7),
                      backgroundColor: Colors.transparent,
                    ),
                    onChanged: (value) => setState(() => aVista = value),
                    iconBuilder:
                        (value) => TextWidget.normal(
                          value ? 'À VISTA' : 'A PRAZO',
                          color: AppColors.background,
                        ),
                  ),
                  const SizedBoxWidget.lg(),
                  ElevatedButtonWidget(
                    label: 'Cadastrar',
                    width: double.infinity,
                    height: 40,
                    onPressed: () async {
                      if (validarCamposPreenchidos()) {
                        QuickAlert.show(
                          context: context,
                          width: 300,
                          confirmBtnText: 'Voltar ao Cadastro',
                          confirmBtnColor: AppColors.primary,
                          type: QuickAlertType.error,
                          title: 'ERRO!',
                          text: 'O campo descrição precisa estar preenchido.',
                        );
                        return;
                      }
                      await cadastrarFormaDePagamento();
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
