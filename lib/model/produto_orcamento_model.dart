import 'package:manager_app/model/produto_model.dart';

class ProdutoOrcamentoModel {
  final ProdutosModel produto;
  final double quantidade;
  final double subtotal;

  ProdutoOrcamentoModel({
    required this.produto,
    required this.quantidade,
    required this.subtotal,
  });
}
