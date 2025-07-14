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
      final resultadosQuery = await db.execute('SELECT * FROM usuarios');
      final todosUsuarios =
          resultadosQuery.map((row) {
            return UsuarioModel.fromMap(row.toColumnMap());
          }).toList();
      for (final usuarioAtual in todosUsuarios) {
        if (usuarioAtual.usuario == usuario &&
            BCrypt.checkpw(senha, usuarioAtual.senha) &&
            usuarioAtual.ativo) {
          Global().setUsuarioAtual(usuarioAtual);
          return {'valido': true, 'erro': null};
        }
      }
    } catch (e) {
      return {'valido': false, 'erro': 'Erro ao validar usuário: $e'};
    }

    return {'valido': false, 'erro': 'Usuário ou senha inválidos.'};
  }
}
