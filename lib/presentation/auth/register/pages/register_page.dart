// ignore_for_file: use_build_context_synchronously

import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/config/app_images.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/main.dart';
import 'package:manager_app/presentation/auth/register/validators/register_validator.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/quick_dialog_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';
import 'package:postgres/postgres.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();
  TextEditingController senhaMestreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Container(
            height: double.infinity,
            width: context.getWidth / 5 + 200,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Card(
                  color: AppColors.background,
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextWidget.title('Bem-vindo!'),
                        //const SizedBoxWidget.sm(),
                        TextWidget.small(
                          'Preencha os campos para criar uma conta.',
                        ),
                        SizedBoxWidget.xl(),
                        TextFormFieldWidget(
                          controller: usuarioController,
                          icon: LucideIcons.userRoundPlus,
                          inputLabel: 'Usuário',
                          maxLength: 100,
                        ),
                        const SizedBoxWidget.md(),
                        TextFormFieldWidget(
                          controller: senhaController,
                          inputLabel: 'Senha',
                          isPassword: true,
                          icon: LucideIcons.lock,
                          maxLength: 30,
                        ),
                        const SizedBoxWidget.md(),
                        TextFormFieldWidget(
                          controller: confirmarSenhaController,
                          inputLabel: 'Confirme a Senha',
                          isPassword: true,
                          icon: LucideIcons.lock,
                          maxLength: 30,
                        ),
                        const SizedBoxWidget.md(),
                        TextFormFieldWidget(
                          controller: senhaMestreController,
                          inputLabel: 'Senha MESTRE',
                          isPassword: true,
                          icon: LucideIcons.shieldAlert,
                          maxLength: 30,
                        ),
                        TextWidget.small(
                          'A senha mestre pode ser alterada a qualquer momento.',
                        ),
                        const SizedBoxWidget.xl(),
                        ElevatedButtonWidget(
                          width: double.infinity,
                          height: 50,
                          label: 'Salvar',
                          onPressed: () async {
                            final valido = await RegisterValidator().validar(
                              usuario: usuarioController.text,
                              senha: senhaController.text,
                              confirmarSenha: confirmarSenhaController.text,
                              senhaMestre: senhaMestreController.text,
                            );

                            if (!valido['valido']) {
                              QuickDialogWidget().erroMsg(
                                context: context,
                                texto: valido['erro'],
                                textoBotao: 'Voltar',
                              );
                              return;
                            }

                            try {
                              final db = await DbService().connection;
                              await db.execute(
                                Sql.named(
                                  'INSERT INTO usuarios (usuario, senha) VALUES (@usuario, @senha)',
                                ),
                                parameters: {
                                  'usuario': usuarioController.text,
                                  'senha': BCrypt.hashpw(
                                    senhaController.text,
                                    BCrypt.gensalt(),
                                  ),
                                },
                              );
                              QuickDialogWidget().sucessoMsg(
                                context: context,
                                texto: 'Conta criada com sucesso!',
                                textoBotao: 'Continuar',
                              );
                              Navigator.pushNamed(context, '/login');
                            } catch (e) {
                              QuickDialogWidget().erroMsg(
                                context: context,
                                texto: 'Erro ao criar conta: $e',
                                textoBotao: 'Voltar',
                              );
                              return;
                            }
                          },
                        ),
                        const SizedBoxWidget.xxxs(),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, '/login'),
                          borderRadius: BorderRadius.circular(3),
                          child: TextWidget.small(
                            ' Clique aqui para voltar para a tela de login. ',
                          ),
                        ),
                        TextWidget.small('Versão $versao'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SvgPicture.asset(
                AppImages.registerImage,
                width: context.getWidth / 5 + 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
