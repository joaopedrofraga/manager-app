class FormaPagamentoModel {
  final int? id;
  final String? descricao;
  final bool? aVista;
  final bool? ativo;

  const FormaPagamentoModel({
    this.id,
    this.descricao,
    this.aVista,
    this.ativo = true,
  });

  FormaPagamentoModel copyWith({
    int? id,
    String? descricao,
    bool? aVista,
    bool? ativo,
  }) {
    return FormaPagamentoModel(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      aVista: aVista ?? this.aVista,
      ativo: ativo ?? this.ativo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'a_vista': aVista,
      'ativo': ativo,
    };
  }

  factory FormaPagamentoModel.fromMap(Map<String, dynamic> map) {
    return FormaPagamentoModel(
      id: map['id'] as int?,
      descricao: map['descricao'] as String?,
      aVista: map['a_vista'] as bool?,
      ativo: map['ativo'] as bool?,
    );
  }

  @override
  String toString() {
    return 'FormaPagamentoModel(id: $id, descricao: $descricao, aVista: $aVista, ativo: $ativo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FormaPagamentoModel &&
        other.id == id &&
        other.descricao == descricao &&
        other.aVista == aVista &&
        other.ativo == ativo;
  }

  @override
  int get hashCode =>
      id.hashCode ^ descricao.hashCode ^ aVista.hashCode ^ ativo.hashCode;
}
