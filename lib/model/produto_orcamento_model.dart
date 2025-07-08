import 'package:manager_app/model/produto_model.dart';

class ProdutoOrcamentoModel {
  final ProdutosModel produto;
  final double quantidade;
  final double valorUnitario;
  final double subtotal;

  ProdutoOrcamentoModel({
    required this.produto,
    required this.quantidade,
    required this.valorUnitario,
    required this.subtotal,
  });

  @override
  String toString() {
    return 'ProdutoOrcamentoModel(produto: $produto, quantidade: $quantidade, valorUnitario: $valorUnitario, subtotal: $subtotal)';
  }
}
