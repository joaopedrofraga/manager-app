import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/model/produto_model.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';

class ProdutoListTileWidget extends StatelessWidget {
  final ProdutosModel produto;
  final Function() onTap;
  const ProdutoListTileWidget({
    super.key,
    required this.produto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget.small(produto.codigo!, overflow: TextOverflow.ellipsis),
          TextWidget.bold(produto.descricao!, overflow: TextOverflow.ellipsis),
        ],
      ),
      subtitle: TextWidget.small(
        'Venda: ${produto.getVendaFormatada()} | Custo: ${produto.getCustoFormatado()}',
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget.normal(
            '${produto.estoque.toString().replaceAll('.', ',')} ${produto.unidade}',
          ),
          const SizedBoxWidget.xxs(),
          Icon(LucideIcons.package),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      hoverColor: AppColors.primary.withValues(alpha: 0.1),
      onTap: onTap,
    );
  }
}
