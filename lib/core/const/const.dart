class Const {
  static final Const _singleton = Const._internal();

  factory Const() {
    return _singleton;
  }

  Const._internal();

  static double get tamanhoMenu => 85;
}
