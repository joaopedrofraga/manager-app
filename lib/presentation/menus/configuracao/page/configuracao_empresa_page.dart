// ignore_for_file: use_build_context_synchronously

import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/core/util/filtros_text_form_field.dart';
import 'package:manager_app/core/util/formatar_cpf_cnpj.dart';
import 'package:manager_app/model/info_empresa_model.dart';
import 'package:manager_app/presentation/extra/senha_mestre_page.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/quick_dialog_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';
import 'package:postgres/postgres.dart';

class ConfiguracaoEmpresaPage extends StatefulWidget {
  const ConfiguracaoEmpresaPage({super.key});

  static Future<void> show(BuildContext context) async {
    final validado = await SenhaMestrePage.validar(context);
    if (validado == null || !validado) {
      return;
    }
    return showDialog(
      context: context,
      builder: (context) => const ConfiguracaoEmpresaPage(),
    );
  }

  @override
  State<ConfiguracaoEmpresaPage> createState() =>
      _ConfiguracaoEmpresaPageState();
}

class _ConfiguracaoEmpresaPageState extends State<ConfiguracaoEmpresaPage> {
  late InfoEmpresaModel infoEmpresa;
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

  @override
  void initState() {
    getConfig();
    super.initState();
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

  void getConfig() async {
    try {
      infoEmpresa = await buscarInfoEmpresa();
      nomeTEC.text = infoEmpresa.nome ?? '';
      fantasiaTEC.text = infoEmpresa.fantasia ?? '';
      cpfCnpjTEC.text = formatarCpfCnpj(infoEmpresa.cpfCnpj ?? '');
      estadoTEC.text = infoEmpresa.estado ?? '';
      cepTEC.text = infoEmpresa.cep ?? '';
      cidadeTEC.text = infoEmpresa.cidade ?? '';
      bairroTEC.text = infoEmpresa.bairro ?? '';
      enderecoTEC.text = infoEmpresa.endereco ?? '';
      numeroTEC.text = infoEmpresa.numero ?? '';
      complementoTEC.text = infoEmpresa.complemento ?? '';
      observacoesTEC.text = infoEmpresa.observacoes ?? '';
      telefoneTEC.text = infoEmpresa.telefone ?? '';
    } catch (e) {
      await QuickDialogWidget().erroMsg(
        context: context,
        texto: 'Erro ao carregar informações da empresa: $e',
        textoBotao: 'Voltar',
      );
    }
  }

  Future<void> atualizarInfoEmpresa() async {
    try {
      final db = await DbService().connection;
      await db.execute(
        Sql.named('''
        UPDATE info_empresa
        SET nome = @nome, fantasia = @fantasia, telefone = @telefone,
            cpf_cnpj = @cpfCnpj, estado = @estado, cep = @cep,
            cidade = @cidade, bairro = @bairro, endereco = @endereco,
            numero = @numero, complemento = @complemento,
            observacoes = @observacoes
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
      await QuickDialogWidget().erroMsg(
        context: context,
        texto: 'Erro ao atualizar as informações: $e',
        textoBotao: 'Voltar para Configuração',
      );
      return;
    }

    await QuickDialogWidget().sucessoMsg(
      context: context,
      texto: 'Informações atualizadas com sucesso.',
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
            constraints: BoxConstraints(maxWidth: context.getWidth * 0.2 + 500),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget.title('Configuração da Empresa'),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(LucideIcons.rotateCcwKey),
                        tooltip: 'Alterar Senha Mestre',
                      ),
                      const SizedBoxWidget.xxxs(),
                      CloseButton(),
                    ],
                  ),
                  TextWidget.small('Os campos obrigatórios aparecem com *'),
                  const SizedBoxWidget.md(),
                  TextFormFieldWidget(
                    controller: nomeTEC,
                    inputLabel: 'Nome/Razão Social*',
                    icon: LucideIcons.contact,
                    maxLength: 300,
                  ),
                  const SizedBoxWidget.sm(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: fantasiaTEC,
                          inputLabel: 'Apelido/Fantasia',
                          //icon: LucideIcons.laugh,
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
                          //icon: LucideIcons.phone,
                          maxLength: 20,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: cpfCnpjTEC,
                          inputLabel: 'CPF/CNPJ*',
                          inputFormatters: [filtroSomenteCaracteresCpfCnpj],
                          //icon: LucideIcons.idCard,
                          maxLength: 18,
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
                          controller: estadoTEC,
                          inputLabel: 'Estado*',
                          maxLength: 2,
                          inputFormatters: [filtroSomenteLetras],
                          //icon: LucideIcons.mapPin,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: cepTEC,
                          inputLabel: 'CEP*',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          //icon: LucideIcons.asterisk,
                          maxLength: 9,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: cidadeTEC,
                          inputLabel: 'Cidade*',
                          inputFormatters: [filtroSomenteLetrasComEspaco],
                          //icon: LucideIcons.mapPinned,
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
                          inputFormatters: [filtroSomenteLetrasComEspaco],
                          //icon: LucideIcons.building2,
                          maxLength: 100,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: enderecoTEC,
                          inputLabel: 'Endereço*',
                          //icon: LucideIcons.locateFixed,
                          maxLength: 255,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: numeroTEC,
                          inputLabel: 'Número*',
                          //icon: LucideIcons.house,
                          maxLength: 20,
                        ),
                      ),
                      const SizedBoxWidget.sm(),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: complementoTEC,
                          inputLabel: 'Complemento',
                          //icon: LucideIcons.circleEllipsis,
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
                    //icon: LucideIcons.telescope,
                  ),
                  const SizedBoxWidget.lg(),
                  ElevatedButtonWidget(
                    label: 'Adicionar Nova Logo (NÃO IMPLEMENTADO AINDA)',
                    width: double.infinity,
                    height: 40,
                    isPrimary: false,
                    icon: LucideIcons.imagePlus,
                    onPressed: () {},
                  ),
                  const SizedBoxWidget.sm(),
                  ElevatedButtonWidget(
                    label: 'Salvar Alterações',
                    width: double.infinity,
                    height: 40,
                    onPressed: () async {
                      if (validarCamposPreenchidos()) {
                        await QuickDialogWidget().erroMsg(
                          context: context,
                          texto:
                              'Existem campos obrigatórios(*) não preenchidos - insira os dados faltantes para finalizar a configuração.',
                          textoBotao: 'Voltar para Configurações',
                        );
                        return;
                      } else if (!CNPJValidator.isValid(cpfCnpjTEC.text) &&
                          !CPFValidator.isValid(cpfCnpjTEC.text)) {
                        await QuickDialogWidget().erroMsg(
                          context: context,
                          texto: 'CPF ou CNPJ inválido.',
                          textoBotao: 'Voltar para Configurações',
                        );
                        return;
                      }
                      await atualizarInfoEmpresa();
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
