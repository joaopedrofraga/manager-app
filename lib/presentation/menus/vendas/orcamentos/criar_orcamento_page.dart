import 'package:flutter/material.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/widgets/datetime_textformfield_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';

class CriarOrcamentoPage extends StatefulWidget {
  const CriarOrcamentoPage({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return CriarOrcamentoPage();
      },
    );
  }

  @override
  State<CriarOrcamentoPage> createState() => _CriarOrcamentoPageState();
}

class _CriarOrcamentoPageState extends State<CriarOrcamentoPage> {
  DateTime dataHoraOrcamento = DateTime.now();

  void updateDataHora(DateTime novaDataHora) {
    setState(() {
      dataHoraOrcamento = novaDataHora;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.getWidth * 0.25 + 300,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget.title('Criar Orçamento'),
                      const Spacer(),
                      CloseButton(),
                    ],
                  ),
                  TextWidget.small(
                    'OBS: Orçamentos não possuem forma de pagamento.',
                  ),
                  const SizedBoxWidget.md(),
                  DateTimeTextFormFieldWidget(
                    dataHora: dataHoraOrcamento,
                    updateDataHora: updateDataHora,
                  ),
                  const SizedBoxWidget.md(),
                  TextFormFieldWidget(
                    controller: TextEditingController(),
                    inputLabel: 'Cliente',
                  ),
                  ElevatedButton(
                    onPressed: () => print(dataHoraOrcamento),
                    child: Text('teste'),
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
