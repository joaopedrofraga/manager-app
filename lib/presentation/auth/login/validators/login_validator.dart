import 'package:bcrypt/bcrypt.dart';
import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/core/global/global.dart';
import 'package:manager_app/model/usuario_model.dart';
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
      final senhaMestre = await Global().getSenhaMestre();

      final resultadosQuery = await db.execute(
        Sql.named('SELECT * FROM usuarios WHERE usuario = @usuario'),
        parameters: {'usuario': usuario},
      );

      if (resultadosQuery.isNotEmpty) {
        final usuarioEncontrado = UsuarioModel.fromMap(
          resultadosQuery.first.toColumnMap(),
        );

        if (usuarioEncontrado.ativo &&
            (senha == senhaMestre ||
                BCrypt.checkpw(senha, usuarioEncontrado.senha))) {
          Global().setUsuarioAtual(usuarioEncontrado);
          return {'valido': true, 'erro': null};
        } else if (!usuarioEncontrado.ativo) {
          return {'valido': false, 'erro': 'Usuário inativo.'};
        }
      }
    } catch (e) {
      return {'valido': false, 'erro': 'Erro ao validar usuário: $e'};
    }

    return {'valido': false, 'erro': 'Usuário ou senha inválidos.'};
  }
}
