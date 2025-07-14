// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/core/config/app_images.dart';
import 'package:manager_app/core/extensions/media_query_extension.dart';
import 'package:manager_app/main.dart';
import 'package:manager_app/presentation/auth/login/validators/login_validator.dart';
import 'package:manager_app/widgets/elevatedbutton_widget.dart';
import 'package:manager_app/widgets/quick_dialog_widget.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextWidget.title('Olá!'),
                          //const SizedBoxWidget.sm(),
                          TextWidget.small(
                            'Faça login para acessar o sistema.',
                          ),
                          SizedBoxWidget.xl(),
                          TextFormFieldWidget(
                            controller: usuarioController,
                            icon: LucideIcons.user,
                            inputLabel: 'Usuário',
                          ),
                          const SizedBoxWidget.md(),
                          TextFormFieldWidget(
                            controller: senhaController,
                            inputLabel: 'Senha',
                            isPassword: true,
                            icon: LucideIcons.lock,
                          ),
                          const SizedBoxWidget.xl(),
                          ElevatedButtonWidget(
                            width: double.infinity,
                            height: 50,
                            label: 'Entrar',
                            onPressed: () async {
                              final valido = await LoginValidator().validar(
                                usuario: usuarioController.text,
                                senha: senhaController.text,
                              );
                              if (!valido['valido']) {
                                await QuickDialogWidget().erroMsg(
                                  context: context,
                                  texto: valido['erro'],
                                  textoBotao: 'Voltar',
                                );
                                setState(() {
                                  usuarioController.clear();
                                  senhaController.clear();
                                });
                                return;
                              }
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/home',
                                (route) => false,
                              );
                            },
                          ),
                          const SizedBoxWidget.xxxs(),
                          InkWell(
                            onTap:
                                () => Navigator.pushNamed(context, '/register'),
                            borderRadius: BorderRadius.circular(3),
                            child: TextWidget.small(
                              ' Clique aqui para criar uma conta. ',
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SvgPicture.asset(
                AppImages.loginImage,
                width: context.getWidth / 5 + 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
