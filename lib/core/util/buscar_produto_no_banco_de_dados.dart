// ignore_for_file: use_build_context_synchronously

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/model/produto_model.dart';
import 'package:manager_app/model/produto_orcamento_model.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/produto_list_tile_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';
import 'package:postgres/postgres.dart';

class BuscarProdutoNoBancoDeDados {
  Future<ProdutoOrcamentoModel?> buscar(
    BuildContext context,
    String codigoOuDescricao,
  ) async {
    try {
      final db = await DbService().connection;
      final resultadosQuery = await db.execute(
        Sql.named('''
          SELECT * FROM produtos 
          WHERE ativo = true AND (codigo ILIKE @codigoOuDescricao OR descricao ILIKE @codigoOuDescricao)
          ORDER BY descricao
          '''),
        parameters: {'codigoOuDescricao': '%$codigoOuDescricao%'},
      );
      final produtos =
          resultadosQuery.map((row) {
            return ProdutosModel.fromMap(row.toColumnMap());
          }).toList();
      if (produtos.isEmpty) return null;

      ProdutosModel? produtoSelecionado;

      if (produtos.length > 1) {
        produtoSelecionado = await showDialog(
          context: context,
          builder:
              (context) => ExibirResultadosProdutos(todosProdutos: produtos),
        );
      } else {
        produtoSelecionado = produtos.single;
      }

      if (produtoSelecionado == null) return null;

      final ProdutoOrcamentoModel? produtoOrcamento = await showDialog(
        context: context,
        builder:
            (context) =>
                DadosProdutoOrcamentoPage(produto: produtoSelecionado!),
      );

      return produtoOrcamento;
    } catch (e) {
      throw Exception('$e');
    }
  }
}

class ExibirResultadosProdutos extends StatelessWidget {
  final List<ProdutosModel> todosProdutos;
  const ExibirResultadosProdutos({super.key, required this.todosProdutos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 550,
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextWidget.title('Lista de Produtos'),
                    const Spacer(),
                    CloseButton(),
                  ],
                ),
                TextWidget.small(
                  'Selecione o produto com base nos resultados.',
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: todosProdutos.length,
                    itemBuilder: (context, index) {
                      final produto = todosProdutos[index];
                      return ProdutoListTileWidget(
                        produto: produto,
                        onTap: () => Navigator.pop(context, produto),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DadosProdutoOrcamentoPage extends StatelessWidget {
  final ProdutosModel produto;
  const DadosProdutoOrcamentoPage({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    final TextEditingController quantidadeController = TextEditingController(
      text: '1',
    );
    final MoneyMaskedTextController valorController = MoneyMaskedTextController(
      initialValue: produto.venda ?? 0.0,
      leftSymbol: 'R\$ ',
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextWidget.title('Adição de Produto'),
                    const Spacer(),
                    CloseButton(),
                  ],
                ),
                TextWidget.small(
                  'Preencha os campos abaixo para inserir o produto.',
                ),
                const SizedBoxWidget.md(),
                TextFormFieldWidget(
                  controller: quantidadeController,
                  inputLabel: 'Quantidade de Produtos',
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  icon: LucideIcons.box,
                ),
                const SizedBoxWidget.md(),
                TextFormFieldWidget(
                  controller: valorController,
                  inputLabel:
                      'Valor Unitário (altere caso possua desconto/acréscimo)',
                  icon: LucideIcons.tag,
                ),
                const SizedBoxWidget.xl(),
                ElevatedButtonWidget(
                  width: double.infinity,
                  height: 40,
                  label: 'Adicionar',
                  onPressed: () {
                    final quantidade =
                        double.tryParse(quantidadeController.text) ?? 1;
                    final valorUnitario = valorController.numberValue;
                    final subtotal = quantidade * valorUnitario;

                    final produtoOrcamento = ProdutoOrcamentoModel(
                      produto: produto,
                      quantidade: quantidade,
                      valorUnitario: valorUnitario,
                      subtotal: subtotal,
                    );

                    Navigator.pop(context, produtoOrcamento);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
