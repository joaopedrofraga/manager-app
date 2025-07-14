class UsuarioModel {
  final int id;
  final String usuario;
  final String senha;
  final DateTime dataCriacao;
  final bool ativo;

  UsuarioModel({
    required this.id,
    required this.usuario,
    required this.senha,
    required this.dataCriacao,
    required this.ativo,
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'] as int,
      usuario: map['usuario'] as String,
      senha: map['senha'] as String,
      dataCriacao: DateTime.parse(map['data_criacao'].toString()),
      ativo: map['ativo'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuario': usuario,
      'senha': senha,
      'data_criacao': dataCriacao.toIso8601String(),
      'ativo': ativo,
    };
  }
}
