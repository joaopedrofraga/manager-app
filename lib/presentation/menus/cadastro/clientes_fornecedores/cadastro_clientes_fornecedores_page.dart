// ignore_for_file: use_build_context_synchronously

import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/quick_dialog_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';
import 'package:postgres/postgres.dart';

class CadastroClientesFornecedoresPage extends StatefulWidget {
  const CadastroClientesFornecedoresPage({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const CadastroClientesFornecedoresPage(),
    );
  }

  @override
  State<CadastroClientesFornecedoresPage> createState() =>
      _CadastroClientesFornecedoresPageState();
}

class _CadastroClientesFornecedoresPageState
    extends State<CadastroClientesFornecedoresPage> {
  TextEditingController nomeTEC = TextEditingController();
  TextEditingController fantasiaTEC = TextEditingController();
  TextEditingController cpfCnpjTEC = TextEditingController();
  TextEditingController estadoTEC = TextEditingController();
  MaskedTextController cepTEC = MaskedTextController(mask: '00000-000');
  TextEditingController cidadeTEC = TextEditingController();
  TextEditingController bairroTEC = TextEditingController();
  TextEditingController enderecoTEC = TextEditingController();
  TextEditingController numeroTEC = TextEditingController();
  TextEditingController complementoTEC = TextEditingController();
  TextEditingController observacoesTEC = TextEditingController();
  TextEditingController telefoneTEC = TextEditingController();
  final somenteLetras = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));
  final letrasComEspaco = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z\s]'),
  );
  final cpfCnpjFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'[0-9.\-\/]'),
  );

  @override
  void dispose() {
    nomeTEC.dispose();
    fantasiaTEC.dispose();
    cpfCnpjTEC.dispose();
    estadoTEC.dispose();
    cepTEC.dispose();
    cidadeTEC.dispose();
    bairroTEC.dispose();
    enderecoTEC.dispose();
    numeroTEC.dispose();
    complementoTEC.dispose();
    observacoesTEC.dispose();
    telefoneTEC.dispose();
    super.dispose();
  }

  bool validarCamposPreenchidos() {
    return nomeTEC.text.isEmpty ||
        cpfCnpjTEC.text.isEmpty ||
        estadoTEC.text.isEmpty ||
        cepTEC.text.isEmpty ||
        cidadeTEC.text.isEmpty ||
        bairroTEC.text.isEmpty ||
        enderecoTEC.text.isEmpty ||
        numeroTEC.text.isEmpty;
  }

  String formatarCpfCnpj(String cpfCnpj) {
    if (CNPJValidator.isValid(cpfCnpj)) {
      return CNPJValidator.format(cpfCnpj);
    } else if (CPFValidator.isValid(cpfCnpj)) {
      return CPFValidator.format(cpfCnpj);
    }
    return cpfCnpj;
  }

  Future<void> cadastrarClienteFornecedor() async {
    try {
      final db = await DbService().connection;
      await db.execute(
        Sql.named('''
        INSERT INTO clientes_fornecedores (
          nome, fantasia, telefone, cpf_cnpj, estado, cep, cidade,
          bairro, endereco, numero, complemento, observacoes
        ) VALUES (
          @nome, @fantasia, @telefone, @cpfCnpj, @estado, @cep,
          @cidade, @bairro, @endereco, @numero, @complemento,
          @observacoes
        )
        '''),
        parameters: {
          'nome': nomeTEC.text,
          'fantasia': fantasiaTEC.text,
          'telefone': telefoneTEC.text,
          'cpfCnpj': formatarCpfCnpj(cpfCnpjTEC.text),
          'estado': estadoTEC.text,
          'cep': cepTEC.text,
          'cidade': cidadeTEC.text,
          'bairro': bairroTEC.text,
          'endereco': enderecoTEC.text,
          'numero': numeroTEC.text,
          'complemento': complementoTEC.text,
          'observacoes': observacoesTEC.text,
        },
      );
    } catch (e) {
      if (e is UniqueViolationException) {
        if (e.code == '23505') {
          await QuickDialogWidget().erroMsg(
            context: context,
            texto: 'CPF/CNPJ de Cliente/Fornecedor já cadastrado no sistema.',
            textoBotao: 'Voltar ao Cadastro',
          );
          return;
        }
      }
      await QuickDialogWidget().erroMsg(
        context: context,
        texto: 'Erro ao cadastrar cliente/fornecedor: $e',
        textoBotao: 'Voltar ao Cadastro',
      );
      return;
    }

    await QuickDialogWidget().sucessoMsg(
      context: context,
      texto: 'Cliente/Fornecedor cadastrado no sistema com sucesso.',
      textoBotao: 'Finalizar',
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
                      TextWidget.title('Cadastro de Clientes/Fornecedores'),
                      const Spacer(),
                      CloseButton(),
                    ],
                  ),
                  TextWidget.small(
                    'Preencha os campos abaixo para cadastrar um novo cliente ou fornecedor.',
                  ),
                  const SizedBoxWidget.md(),
                  TextFormFieldWidget(
                    controller: nomeTEC,
                    inputLabel: 'Nome do Cliente/Fornecedor*',
                    icon: LucideIcons.contact,
                    maxLength: 300,
                  ),
                  const SizedBoxWidget.sm(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: fantasiaTEC,
                          inputLabel: 'Fantasia/Apelido',
                          icon: LucideIcons.laugh,
                          maxLength: 250,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: telefoneTEC,
                          inputLabel: 'Telefone',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          icon: LucideIcons.phone,
                          maxLength: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBoxWidget.sm(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: cpfCnpjTEC,
                          inputLabel: 'CPF/CNPJ*',
                          inputFormatters: [cpfCnpjFormatter],
                          icon: LucideIcons.idCard,
                          maxLength: 18,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: estadoTEC,
                          inputLabel: 'Estado*',
                          maxLength: 2,
                          inputFormatters: [somenteLetras],
                          icon: LucideIcons.mapPin,
                        ),
                      ),
                    ],
                  ),
                  const SizedBoxWidget.sm(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: cepTEC,
                          inputLabel: 'CEP*',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          icon: LucideIcons.asterisk,
                          maxLength: 9,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: cidadeTEC,
                          inputLabel: 'Cidade*',
                          inputFormatters: [letrasComEspaco],
                          icon: LucideIcons.mapPinned,
                          maxLength: 100,
                        ),
                      ),
                    ],
                  ),
                  const SizedBoxWidget.sm(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: bairroTEC,
                          inputLabel: 'Bairro*',
                          inputFormatters: [letrasComEspaco],
                          icon: LucideIcons.building2,
                          maxLength: 100,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: enderecoTEC,
                          inputLabel: 'Endereço*',
                          icon: LucideIcons.locateFixed,
                          maxLength: 255,
                        ),
                      ),
                    ],
                  ),
                  const SizedBoxWidget.sm(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: numeroTEC,
                          inputLabel: 'Número*',
                          icon: LucideIcons.house,
                          maxLength: 20,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: complementoTEC,
                          inputLabel: 'Complemento',
                          icon: LucideIcons.circleEllipsis,
                          maxLength: 100,
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
                        await QuickDialogWidget().erroMsg(
                          context: context,
                          texto:
                              'Existem campos obrigatórios(*) não preenchidos - insira os dados faltantes para finalizar o cadastro.',
                          textoBotao: 'Voltar ao Cadastro',
                        );
                        return;
                      } else if (!CNPJValidator.isValid(cpfCnpjTEC.text) &&
                          !CPFValidator.isValid(cpfCnpjTEC.text)) {
                        await QuickDialogWidget().erroMsg(
                          context: context,
                          texto: 'CPF ou CNPJ inválido.',
                          textoBotao: 'Voltar ao Cadastro',
                        );
                        return;
                      }
                      await cadastrarClienteFornecedor();
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
