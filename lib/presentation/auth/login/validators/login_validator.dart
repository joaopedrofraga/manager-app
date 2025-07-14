import 'package:bcrypt/bcrypt.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:postgres/postgres.dart';

class LoginValidator {
  static final LoginValidator _singleton = LoginValidator._internal();

  factory LoginValidator() {
    return _singleton;
  }

  LoginValidator._internal();

  Future<Map<String, dynamic>> validar({
    required String usuario,
    required String senha,
  }) async {
    if (usuario.isEmpty || senha.isEmpty) {
      return {
        'valido': false,
        'erro': 'Usuário e senha devem ser preenchidos.',
      };
    }

    try {
      final db = await DbService().connection;
      final resultadosQuery = await db.execute(
        Sql.named('SELECT senha FROM usuarios WHERE usuario = @usuario'),
        parameters: {'usuario': usuario},
      );
      if (resultadosQuery.isEmpty) {
        return {'valido': false, 'erro': 'Usuário ou senha inválidos.'};
      }
      bool senhaCorreta = BCrypt.checkpw(
        senha,
        resultadosQuery.single.single.toString(),
      );
      if (!senhaCorreta) {
        return {'valido': false, 'erro': 'Usuário ou senha inválidos.'};
      }
    } catch (e) {
      return {'valido': false, 'erro': 'Erro ao validar usuário: $e'};
    }

    return {'valido': true, 'erro': null};
  }
}
