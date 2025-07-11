import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:postgres/postgres.dart';

class RegisterValidator {
  static final RegisterValidator _singleton = RegisterValidator._internal();

  factory RegisterValidator() {
    return _singleton;
  }

  RegisterValidator._internal();

  Future<Map<String, dynamic>> validar({
    required String usuario,
    required String senha,
    required String confirmarSenha,
    required String senhaMestre,
  }) async {
    if (usuario.isEmpty ||
        senha.isEmpty ||
        confirmarSenha.isEmpty ||
        senhaMestre.isEmpty) {
      return {
        'valido': false,
        'erro': 'Todos os campos devem ser preenchidos.',
      };
    }

    if (senha != confirmarSenha) {
      return {'valido': false, 'erro': 'As senhas não coincidem.'};
    }

    // HASH
    final hashMestre = BCrypt.hashpw(senhaMestre, BCrypt.gensalt());
    debugPrint('Hash da senha mestre: $hashMestre');

    // TESTE DE HASH (SEMPRE VAI DAR TRUE)
    debugPrint(BCrypt.checkpw(senhaMestre, hashMestre).toString());

    try {
      final db = await DbService().connection;
      final resultadosQuery = await db.execute(
        Sql.named(
          'SELECT * FROM info_empresa WHERE senha_mestre = @senhaMestre',
        ),
        parameters: {'senhaMestre': senhaMestre},
      );
      if (resultadosQuery.isEmpty) {
        return {'valido': false, 'erro': 'Senha mestre inválida.'};
      }
    } catch (e) {
      return {'valido': false, 'erro': 'Erro ao validar a senha mestre: $e'};
    }

    return {'valido': true, 'erro': null};
  }
}
