// ignore_for_file: use_build_context_synchronously

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/model/forma_pagamento_model.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/quick_dialog_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';
import 'package:postgres/postgres.dart';

class VisualizarAlterarFormaDePagamentoPage extends StatefulWidget {
  final FormaPagamentoModel formaPagamento;

  const VisualizarAlterarFormaDePagamentoPage({
    super.key,
    required this.formaPagamento,
  });

  static Future<void> show(
    BuildContext context,
    FormaPagamentoModel formaPagamento,
  ) {
    return showDialog(
      context: context,
      builder:
          (context) => VisualizarAlterarFormaDePagamentoPage(
            formaPagamento: formaPagamento,
          ),
    );
  }

  @override
  State<VisualizarAlterarFormaDePagamentoPage> createState() =>
      _VisualizarAlterarFormaDePagamentoPageState();
}

class _VisualizarAlterarFormaDePagamentoPageState
    extends State<VisualizarAlterarFormaDePagamentoPage> {
  late final TextEditingController descricaoTEC;
  late bool aVista;

  @override
  void initState() {
    super.initState();
    descricaoTEC = TextEditingController(text: widget.formaPagamento.descricao);
    aVista = widget.formaPagamento.aVista ?? true;
  }

  @override
  void dispose() {
    descricaoTEC.dispose();
    super.dispose();
  }

  bool validarCamposPreenchidos() {
    return descricaoTEC.text.isEmpty;
  }

  Future<void> _handleAlterar() async {
    if (validarCamposPreenchidos()) {
      await QuickDialogWidget().erroMsg(
        context: context,
        texto: 'O campo descrição precisa estar preenchido.',
        textoBotao: 'Voltar',
      );
      return;
    }

    try {
      final db = await DbService().connection;
      await db.execute(
        Sql.named('''
          UPDATE formas_pagamento SET
            descricao = @descricao,
            a_vista = @aVista
          WHERE id = @id
        '''),
        parameters: {
          'id': widget.formaPagamento.id,
          'descricao': descricaoTEC.text,
          'aVista': aVista,
        },
      );
      Navigator.pop(context);
      Navigator.pop(context);
      await QuickDialogWidget().sucessoMsg(
        context: context,
        texto: 'Forma de pagamento alterada com sucesso.',
        textoBotao: 'Finalizar',
      );
    } catch (e) {
      await QuickDialogWidget().erroMsg(
        context: context,
        texto: 'Erro ao alterar a forma de pagamento: $e',
        textoBotao: 'Voltar',
      );
    }
  }

  Future<void> _handleExcluir() async {
    await QuickDialogWidget().alertaMsg(
      context: context,
      texto: 'Deseja realmente excluir esta forma de pagamento?',
      textoBotao: 'Sim, excluir!',
      onConfirm: () {
        Navigator.pop(context);
        _executarExclusao();
      },
    );
  }

  Future<void> _executarExclusao() async {
    try {
      final db = await DbService().connection;
      await db.execute(
        Sql.named('UPDATE formas_pagamento SET ativo = false WHERE id = @id'),
        parameters: {'id': widget.formaPagamento.id},
      );
      Navigator.pop(context);
      Navigator.pop(context);
      await QuickDialogWidget().sucessoMsg(
        context: context,
        texto: 'Forma de pagamento excluída com sucesso.',
        textoBotao: 'Finalizar',
      );
    } catch (e) {
      await QuickDialogWidget().erroMsg(
        context: context,
        texto: 'Erro ao excluir a forma de pagamento: $e',
        textoBotao: 'Voltar',
      );
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
                      TextWidget.title('Alterar Forma de Pagamento'),
                      const Spacer(),
                      CloseButton(onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                  TextWidget.small(
                    'Altere os campos abaixo ou exclua o cadastro.',
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
                    'Selecione a modalidade da forma de pagamento:',
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
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButtonWidget(
                          label: 'Excluir',
                          height: 40,
                          onPressed: _handleExcluir,
                          backgroundColor: Colors.red.shade700,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: ElevatedButtonWidget(
                          label: 'Salvar Alterações',
                          height: 40,
                          onPressed: _handleAlterar,
                        ),
                      ),
                    ],
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
