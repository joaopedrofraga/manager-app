import 'package:manager_app/core/database/db_service.dart';
import 'package:manager_app/model/usuario_model.dart';

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
}
