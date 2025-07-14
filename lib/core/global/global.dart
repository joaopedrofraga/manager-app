import 'package:manager_app/model/usuario_model.dart';

class Global {
  static final Global _singleton = Global._internal();

  factory Global() {
    return _singleton;
  }

  Global._internal();

  late UsuarioModel usuarioAtual;

  void setUsuarioAtual(UsuarioModel usuario) {
    usuarioAtual = usuario;
  }

  static UsuarioModel get getUsuarioAtual => _singleton.usuarioAtual;
}
