import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/model/produto_orcamento_model.dart';
import 'package:manager_app/widgets/text_widget.dart';

class ProdutoOrcamentoListTileWidget extends StatelessWidget {
  final ProdutoOrcamentoModel produtoOrcamento;
  final Function() onTap;
  const ProdutoOrcamentoListTileWidget({
    super.key,
    required this.produtoOrcamento,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextWidget.bold(
        produtoOrcamento.produto.descricao!,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget.small(
            'R\$ ${produtoOrcamento.valorUnitario.toStringAsFixed(2).replaceAll('.', ',')} * ${produtoOrcamento.quantidade} = ',
          ),
          TextWidget.small(
            'R\$ ${produtoOrcamento.subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      hoverColor: AppColors.primary.withValues(alpha: 0.1),
      onTap: onTap,
    );
  }
}
