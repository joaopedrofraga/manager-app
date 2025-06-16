import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class QuickDialogWidget {
  static final QuickDialogWidget _singleton = QuickDialogWidget._internal();

  factory QuickDialogWidget() {
    return _singleton;
  }

  QuickDialogWidget._internal();

  Future<dynamic> erroMsg({
    required BuildContext context,

    required String texto,
    required String textoBotao,
  }) {
    return QuickAlert.show(
      context: context,
      width: 300,
      confirmBtnText: textoBotao,
      confirmBtnColor: AppColors.primary,
      type: QuickAlertType.error,
      title: 'ERRO!',
      text: texto,
    );
  }

  Future<dynamic> sucessoMsg({
    required BuildContext context,

    required String texto,
    required String textoBotao,
  }) {
    return QuickAlert.show(
      context: context,
      width: 300,
      confirmBtnText: textoBotao,
      confirmBtnColor: AppColors.primary,
      type: QuickAlertType.success,
      title: 'SUCESSO!',
      text: texto,
    );
  }

  Future<dynamic> alertaMsg({
    required BuildContext context,
    required String texto,
    required String textoBotao,
    required Function() onConfirm,
  }) {
    return QuickAlert.show(
      context: context,
      width: 300,
      confirmBtnText: textoBotao,
      confirmBtnColor: AppColors.primary,
      cancelBtnText: 'Cancelar',
      showCancelBtn: true,
      type: QuickAlertType.warning,
      title: 'ATENÇÃO!',
      text: texto,
      onConfirmBtnTap: onConfirm,
    );
  }
}
