import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/model/produto_orcamento_model.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget.small(
            produtoOrcamento.produto.codigo!,
            overflow: TextOverflow.ellipsis,
          ),
          TextWidget.bold(
            produtoOrcamento.produto.descricao!,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      subtitle: TextWidget.small(
        'Valor UN: ${produtoOrcamento.valorUnitario} | Quantidade: ${produtoOrcamento.quantidade}',
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget.normal(
            'Subtotal: R\$ ${produtoOrcamento.subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
          ),
          const SizedBoxWidget.xxs(),
          Icon(LucideIcons.coins),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      hoverColor: AppColors.primary.withValues(alpha: 0.1),
      onTap: onTap,
    );
  }
}
