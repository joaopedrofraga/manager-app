import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/model/usuario_model.dart';
import 'package:postgres/postgres.dart';

class Global {
  static final Global _singleton = Global._internal();

  factory Global() {
    return _singleton;
  }

  Global._internal();

  late UsuarioModel? usuarioAtual;

  void setUsuarioAtual(UsuarioModel? usuario) {
    usuarioAtual = usuario;
  }

  void clearUsuarioAtual() {
    usuarioAtual = null;
  }

  static UsuarioModel get getUsuarioAtual => _singleton.usuarioAtual!;

  Future<String> getSenhaMestre() async {
    final db = await DbService().connection;
    final senhaMestre = await db.execute(
      'SELECT senha_mestre FROM info_empresa',
    );
    return senhaMestre.single.single.toString();
  }

  Future<void> setSenhaMestre(String senha) async {
    final db = await DbService().connection;
    await db.execute(
      Sql.named('UPDATE info_empresa SET senha_mestre = @senha'),
      parameters: {'senha': senha},
    );
  }
}
