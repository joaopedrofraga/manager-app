import 'package:flutter/material.dart';
import 'package:manager_app/widgets/text_widget.dart';

class CadastroProdutosPage extends StatefulWidget {
  static const String routeName = '/cadastro/produtos';
  const CadastroProdutosPage({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => Scaffold(
            backgroundColor: Colors.transparent,
            body: Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget.title('Cadastro de Produtos'),
                      CloseButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  State<CadastroProdutosPage> createState() => _CadastroProdutosPageState();
}

class _CadastroProdutosPageState extends State<CadastroProdutosPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
