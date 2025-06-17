import 'package:flutter/services.dart';

final filtroSomenteLetras = FilteringTextInputFormatter.allow(
  RegExp(r'[a-zA-Z]'),
);
final filtroSomenteLetrasComEspaco = FilteringTextInputFormatter.allow(
  RegExp(r'[a-zA-Z\s]'),
);
final filtroSomenteCaracteresCpfCnpj = FilteringTextInputFormatter.allow(
  RegExp(r'[0-9.\-\/]'),
);

final filtroNumerosComVirgula = FilteringTextInputFormatter.allow(
  RegExp(r'[0-9,]'),
);
