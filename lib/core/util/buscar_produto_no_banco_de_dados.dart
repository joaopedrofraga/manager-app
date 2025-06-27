// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/model/produto_model.dart';
import 'package:manager_app/widgets/produto_list_tile_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:postgres/postgres.dart';

class BuscarProdutoNoBancoDeDados {
  Future<ProdutosModel?> buscar(
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
      if (produtos.length == 1) return produtos.single;

      final ProdutosModel? produtoSelecionado = await showDialog(
        context: context,
        builder: (context) => ExibirResultadosProdutos(todosProdutos: produtos),
      );
      return produtoSelecionado;
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
