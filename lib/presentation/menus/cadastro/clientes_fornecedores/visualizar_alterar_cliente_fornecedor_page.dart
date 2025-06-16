// ignore_for_file: use_build_context_synchronously

import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/model/cliente_fornecedor_model.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/quick_dialog_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';
import 'package:postgres/postgres.dart';

class VisualizarAlterarClienteFornecedoresPage extends StatefulWidget {
  final ClienteFornecedorModel cliente;

  const VisualizarAlterarClienteFornecedoresPage({
    super.key,
    required this.cliente,
  });

  static Future<void> show(
    BuildContext context,
    ClienteFornecedorModel cliente,
  ) {
    return showDialog(
      context: context,
      builder:
          (context) =>
              VisualizarAlterarClienteFornecedoresPage(cliente: cliente),
    );
  }

  @override
  State<VisualizarAlterarClienteFornecedoresPage> createState() =>
      _VisualizarAlterarClienteFornecedoresPageState();
}

class _VisualizarAlterarClienteFornecedoresPageState
    extends State<VisualizarAlterarClienteFornecedoresPage> {
  late final TextEditingController nomeTEC;
  late final TextEditingController fantasiaTEC;
  late final TextEditingController cpfCnpjTEC;
  late final TextEditingController estadoTEC;
  late final MaskedTextController cepTEC;
  late final TextEditingController cidadeTEC;
  late final TextEditingController bairroTEC;
  late final TextEditingController enderecoTEC;
  late final TextEditingController numeroTEC;
  late final TextEditingController complementoTEC;
  late final TextEditingController observacoesTEC;
  late final TextEditingController telefoneTEC;

  final somenteLetras = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));
  final letrasComEspaco = RegExp(r'[a-zA-Z\s]');
  final cpfCnpjFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'[0-9.\-\/]'),
  );

  @override
  void initState() {
    super.initState();
    nomeTEC = TextEditingController(text: widget.cliente.nome);
    fantasiaTEC = TextEditingController(text: widget.cliente.fantasia);
    cpfCnpjTEC = TextEditingController(text: widget.cliente.cpfCnpj);
    estadoTEC = TextEditingController(text: widget.cliente.estado);
    cepTEC = MaskedTextController(mask: '00000-000', text: widget.cliente.cep);
    cidadeTEC = TextEditingController(text: widget.cliente.cidade);
    bairroTEC = TextEditingController(text: widget.cliente.bairro);
    enderecoTEC = TextEditingController(text: widget.cliente.endereco);
    numeroTEC = TextEditingController(text: widget.cliente.numero);
    complementoTEC = TextEditingController(text: widget.cliente.complemento);
    observacoesTEC = TextEditingController(text: widget.cliente.observacoes);
    telefoneTEC = TextEditingController(text: widget.cliente.telefone);
  }

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

  Future<void> _handleAlterar() async {
    if (validarCamposPreenchidos()) {
      await QuickDialogWidget().erroMsg(
        context: context,
        texto:
            'Existem campos obrigatórios(*) não preenchidos - insira os dados faltantes para finalizar o cadastro.',
        textoBotao: 'Voltar ao Cadastro',
      );
      return;
    }
    if (!CNPJValidator.isValid(
          cpfCnpjTEC.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) &&
        !CPFValidator.isValid(
          cpfCnpjTEC.text.replaceAll(RegExp(r'[^0-9]'), ''),
        )) {
      await QuickDialogWidget().erroMsg(
        context: context,
        texto: 'CPF ou CNPJ inválido.',
        textoBotao: 'Voltar ao Cadastro',
      );
      return;
    }

    try {
      final db = await DbService().connection;
      await db.execute(
        Sql.named('''
          UPDATE clientes_fornecedores SET
            nome = @nome,
            fantasia = @fantasia,
            telefone = @telefone,
            cpf_cnpj = @cpfCnpj,
            estado = @estado,
            cep = @cep,
            cidade = @cidade,
            bairro = @bairro,
            endereco = @endereco,
            numero = @numero,
            complemento = @complemento,
            observacoes = @observacoes
          WHERE id = @id
        '''),
        parameters: {
          'id': widget.cliente.id,
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
      Navigator.pop(context);
      Navigator.pop(context);
      await QuickDialogWidget().sucessoMsg(
        context: context,
        texto: 'Cliente/Fornecedor alterado no sistema com sucesso.',
        textoBotao: 'Finalizar',
      );
    } catch (e) {
      await QuickDialogWidget().erroMsg(
        context: context,
        texto: 'Erro ao alterar o cliente/fornecedor: $e',
        textoBotao: 'Voltar ao Cadastro',
      );
    }
  }

  Future<void> _handleExcluir() async {
    await QuickDialogWidget().alertaMsg(
      context: context,
      texto: 'Deseja realmente excluir este cadastro?',
      textoBotao: 'Sim, excluir!',
      onConfirm: () {
        Navigator.pop(context);
        _executarExclusao();
      },
    );
  }

  Future<void> _executarExclusao() async {
    try {
      final db = await DbService().connection;
      await db.execute(
        Sql.named(
          'UPDATE clientes_fornecedores SET ativo = false WHERE id = @id',
        ),
        parameters: {'id': widget.cliente.id},
      );
      Navigator.pop(context);
      Navigator.pop(context);

      await QuickDialogWidget().sucessoMsg(
        context: context,
        texto: 'Cadastro excluído com sucesso.',
        textoBotao: 'Finalizar',
      );
    } catch (e) {
      await QuickDialogWidget().erroMsg(
        context: context,
        texto: 'Erro ao excluir o cadastro: $e',
        textoBotao: 'Voltar ao Cadastro',
      );
    }
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
                      TextWidget.title('Alterar Cadastro'),
                      const Spacer(),
                      CloseButton(
                        onPressed: () => Navigator.pop(context, false),
                      ),
                    ],
                  ),
                  TextWidget.small(
                    'Altere os campos abaixo ou exclua o cadastro.',
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
                          icon: LucideIcons.asterisk,
                          maxLength: 9,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: cidadeTEC,
                          inputLabel: 'Cidade*',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(letrasComEspaco),
                          ],
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
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(letrasComEspaco),
                          ],
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
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButtonWidget(
                          label: 'Excluir',
                          height: 40,
                          onPressed: _handleExcluir,
                          backgroundColor: Colors.red.shade700,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: ElevatedButtonWidget(
                          label: 'Salvar Alterações',
                          height: 40,
                          onPressed: _handleAlterar,
                        ),
                      ),
                    ],
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
