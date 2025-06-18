// ignore_for_file: use_build_context_synchronously

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/core/util/filtros_text_form_field.dart';
import 'package:manager_app/model/produto_model.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/quick_dialog_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';
import 'package:postgres/postgres.dart';

class VisualizarAlterarProdutoPage extends StatefulWidget {
  final ProdutosModel produto;

  const VisualizarAlterarProdutoPage({super.key, required this.produto});

  static Future<void> show(BuildContext context, ProdutosModel produto) {
    return showDialog(
      context: context,
      builder: (context) => VisualizarAlterarProdutoPage(produto: produto),
    );
  }

  @override
  State<VisualizarAlterarProdutoPage> createState() =>
      _VisualizarAlterarProdutoPageState();
}

class _VisualizarAlterarProdutoPageState
    extends State<VisualizarAlterarProdutoPage> {
  late final TextEditingController codigoTEC;
  late final TextEditingController descricaoTEC;
  late final MoneyMaskedTextController valorCustoTEC;
  late final MoneyMaskedTextController valorVendaTEC;
  late final TextEditingController estoqueTEC;
  late final TextEditingController unidadeMedidaTEC;
  late final TextEditingController observacoesTEC;

  @override
  void initState() {
    super.initState();
    codigoTEC = TextEditingController(text: widget.produto.codigo);
    descricaoTEC = TextEditingController(text: widget.produto.descricao);
    valorCustoTEC = MoneyMaskedTextController(
      leftSymbol: 'R\$ ',
      initialValue: widget.produto.custo ?? 0,
    );
    valorVendaTEC = MoneyMaskedTextController(
      leftSymbol: 'R\$ ',
      initialValue: widget.produto.venda ?? 0,
    );
    estoqueTEC = TextEditingController(
      text: widget.produto.estoque?.toString() ?? '0',
    );
    unidadeMedidaTEC = TextEditingController(text: widget.produto.unidade);
    observacoesTEC = TextEditingController(text: widget.produto.observacoes);
  }

  @override
  void dispose() {
    codigoTEC.dispose();
    descricaoTEC.dispose();
    valorCustoTEC.dispose();
    valorVendaTEC.dispose();
    estoqueTEC.dispose();
    unidadeMedidaTEC.dispose();
    observacoesTEC.dispose();
    super.dispose();
  }

  bool validarCamposPreenchidos() {
    return codigoTEC.text.isEmpty ||
        descricaoTEC.text.isEmpty ||
        valorVendaTEC.text.isEmpty ||
        estoqueTEC.text.isEmpty ||
        unidadeMedidaTEC.text.isEmpty;
  }

  Future<void> _handleAlterar() async {
    if (validarCamposPreenchidos()) {
      await QuickDialogWidget().erroMsg(
        context: context,
        texto:
            'Existem campos obrigatórios(*) não preenchidos - insira os dados faltantes para finalizar o cadastro.',
        textoBotao: 'Voltar',
      );
      return;
    }

    try {
      final db = await DbService().connection;
      await db.execute(
        Sql.named('''
          UPDATE produtos SET
            codigo = @codigo,
            descricao = @descricao,
            custo = @custo,
            venda = @venda,
            estoque = @estoque,
            unidade = @unidade,
            observacoes = @observacoes
          WHERE id = @id
        '''),
        parameters: {
          'id': widget.produto.id,
          'codigo': codigoTEC.text,
          'descricao': descricaoTEC.text,
          'custo': valorCustoTEC.numberValue,
          'venda': valorVendaTEC.numberValue,
          'estoque': double.tryParse(estoqueTEC.text.replaceAll(',', '.')) ?? 0,
          'unidade': unidadeMedidaTEC.text,
          'observacoes': observacoesTEC.text,
        },
      );
      Navigator.pop(context);
      Navigator.pop(context);
      await QuickDialogWidget().sucessoMsg(
        context: context,
        texto: 'Produto alterado no sistema com sucesso.',
        textoBotao: 'Finalizar',
      );
    } catch (e) {
      await QuickDialogWidget().erroMsg(
        context: context,
        texto: 'Erro ao alterar o produto: $e',
        textoBotao: 'Voltar',
      );
    }
  }

  Future<void> _handleExcluir() async {
    await QuickDialogWidget().alertaMsg(
      context: context,
      texto: 'Deseja realmente excluir este produto?',
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
        Sql.named('UPDATE produtos SET ativo = false WHERE id = @id'),
        parameters: {'id': widget.produto.id},
      );
      Navigator.pop(context);
      Navigator.pop(context);
      await QuickDialogWidget().sucessoMsg(
        context: context,
        texto: 'Produto excluído com sucesso.',
        textoBotao: 'Finalizar',
      );
    } catch (e) {
      await QuickDialogWidget().erroMsg(
        context: context,
        texto: 'Erro ao excluir o produto: $e',
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
                      TextWidget.title('Alterar Cadastro de Produto'),
                      const Spacer(),
                      CloseButton(onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                  TextWidget.small(
                    'Altere os campos abaixo ou exclua o produto.',
                  ),
                  const SizedBoxWidget.md(),
                  TextFormFieldWidget(
                    controller: codigoTEC,
                    inputLabel: 'Código do Produto*',
                    maxLength: 50,
                    icon: LucideIcons.qrCode,
                  ),
                  const SizedBoxWidget.sm(),
                  TextFormFieldWidget(
                    controller: descricaoTEC,
                    inputLabel: 'Descrição do Produto*',
                    maxLength: 255,
                    icon: LucideIcons.shoppingBasket,
                  ),
                  const SizedBoxWidget.sm(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: valorCustoTEC,
                          inputLabel: 'Valor de Custo',
                          icon: LucideIcons.coins,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: valorVendaTEC,
                          inputLabel: 'Valor de Venda*',
                          icon: LucideIcons.handCoins,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBoxWidget.sm(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: estoqueTEC,
                          inputLabel: 'Estoque*',
                          icon: LucideIcons.packageOpen,
                          inputFormatters: [filtroNumerosComVirgula],
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: unidadeMedidaTEC,
                          inputLabel: 'Unidade de Medida*',
                          icon: LucideIcons.pencilRuler,
                          maxLength: 5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBoxWidget.sm(),
                  TextFormFieldWidget(
                    controller: observacoesTEC,
                    inputLabel: 'Observações',
                    maxLines: 3,
                    icon: LucideIcons.telescope,
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
