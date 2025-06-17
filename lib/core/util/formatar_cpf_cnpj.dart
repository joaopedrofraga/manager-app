import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

String formatarCpfCnpj(String cpfCnpj) {
  if (CNPJValidator.isValid(cpfCnpj)) {
    return CNPJValidator.format(cpfCnpj);
  } else if (CPFValidator.isValid(cpfCnpj)) {
    return CPFValidator.format(cpfCnpj);
  }
  return cpfCnpj;
}
