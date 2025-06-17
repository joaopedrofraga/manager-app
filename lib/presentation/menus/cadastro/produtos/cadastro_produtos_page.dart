// ignore_for_file: use_build_context_synchronously

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/core/util/filtros_text_form_field.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';
import 'package:postgres/postgres.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class CadastroProdutosPage extends StatefulWidget {
  const CadastroProdutosPage({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const CadastroProdutosPage(),
    );
  }

  @override
  State<CadastroProdutosPage> createState() => _CadastroProdutosPageState();
}

class _CadastroProdutosPageState extends State<CadastroProdutosPage> {
  TextEditingController codigoTEC = TextEditingController();
  TextEditingController descricaoTEC = TextEditingController();
  MoneyMaskedTextController valorCustoTEC = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
  );
  MoneyMaskedTextController valorVendaTEC = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
  );
  TextEditingController estoqueTEC = TextEditingController();
  TextEditingController unidadeMedidaTEC = TextEditingController();
  TextEditingController observacoesTEC = TextEditingController();

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

  Future<void> cadastrarProduto() async {
    try {
      final db = await DbService().connection;
      await db.execute(
        Sql.named('''
          INSERT INTO produtos (
            codigo, descricao, custo, venda, estoque, unidade, observacoes
          ) VALUES (
            @codigo, @descricao, @custo, @venda, @estoque, @unidade, @observacoes
          )
          '''),
        parameters: {
          'codigo': codigoTEC.text,
          'descricao': descricaoTEC.text,
          'custo': valorCustoTEC.numberValue,
          'venda': valorVendaTEC.numberValue,
          'estoque': double.parse(estoqueTEC.text),
          'unidade': unidadeMedidaTEC.text,
          'observacoes': observacoesTEC.text,
        },
      );
    } catch (e) {
      if (e is UniqueViolationException) {
        if (e.code == '23505') {
          QuickAlert.show(
            context: context,
            width: 300,
            confirmBtnText: 'Voltar ao Cadastro',
            confirmBtnColor: AppColors.primary,
            type: QuickAlertType.error,
            title: 'ERRO!',
            text: 'Código do produto já cadastrado no sistema.',
          );
          return;
        }
      }
      QuickAlert.show(
        context: context,
        width: 300,
        confirmBtnText: 'Voltar ao Cadastro',
        confirmBtnColor: AppColors.primary,
        type: QuickAlertType.error,
        title: 'ERRO!',
        text: 'Erro ao cadastrar produto: $e',
      );
      return;
    }
    await QuickAlert.show(
      context: context,
      width: 300,
      confirmBtnText: 'Finalizar',
      confirmBtnColor: AppColors.primary,
      type: QuickAlertType.success,
      title: 'SUCESSO!',
      text: 'Produto cadastrado no sistema com sucesso.',
    );
    Navigator.pop(context);
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
                      TextWidget.title('Cadastro de Produtos'),
                      const Spacer(),
                      CloseButton(),
                    ],
                  ),
                  TextWidget.small(
                    'Preencha os campos abaixo para cadastrar um novo produto.',
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
                  ElevatedButtonWidget(
                    label: 'Cadastrar',
                    width: double.infinity,
                    height: 40,
                    onPressed: () async {
                      if (validarCamposPreenchidos()) {
                        QuickAlert.show(
                          context: context,
                          width: 300,
                          confirmBtnText: 'Voltar ao Cadastro',
                          confirmBtnColor: AppColors.primary,
                          type: QuickAlertType.error,
                          title: 'ERRO!',
                          text:
                              'Existem campos obrigatórios(*) não preenchidos - insira os dados faltantes para finalizar o cadastro.',
                        );
                        return;
                      }
                      await cadastrarProduto();
                    },
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
