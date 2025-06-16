class ClienteFornecedorModel {
  final int? id;
  final String? nome;
  final String? fantasia;
  final String? telefone;
  final String? cpfCnpj;
  final String? estado;
  final String? cep;
  final String? cidade;
  final String? bairro;
  final String? endereco;
  final String? numero;
  final String? complemento;
  final String? observacoes;
  final bool? ativo;

  const ClienteFornecedorModel({
    this.id,
    this.nome,
    this.fantasia,
    this.telefone,
    this.cpfCnpj,
    this.estado,
    this.cep,
    this.cidade,
    this.bairro,
    this.endereco,
    this.numero,
    this.complemento,
    this.observacoes,
    this.ativo = true,
  });

  ClienteFornecedorModel copyWith({
    int? id,
    String? nome,
    String? fantasia,
    String? telefone,
    String? cpfCnpj,
    String? estado,
    String? cep,
    String? cidade,
    String? bairro,
    String? endereco,
    String? numero,
    String? complemento,
    String? observacoes,
    bool? ativo,
  }) {
    return ClienteFornecedorModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      fantasia: fantasia ?? this.fantasia,
      telefone: telefone ?? this.telefone,
      cpfCnpj: cpfCnpj ?? this.cpfCnpj,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      cidade: cidade ?? this.cidade,
      bairro: bairro ?? this.bairro,
      endereco: endereco ?? this.endereco,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      observacoes: observacoes ?? this.observacoes,
      ativo: ativo ?? this.ativo,
    );
  }

  String getEnderecoFormatado() {
    return '$endereco, $numero${complemento != '' ? ' - $complemento' : ''}, $bairro, $cidade - $estado, CEP: $cep';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'fantasia': fantasia,
      'telefone': telefone,
      'cpf_cnpj': cpfCnpj,
      'estado': estado,
      'cep': cep,
      'cidade': cidade,
      'bairro': bairro,
      'endereco': endereco,
      'numero': numero,
      'complemento': complemento,
      'observacoes': observacoes,
      'ativo': ativo,
    };
  }

  factory ClienteFornecedorModel.fromMap(Map<String, dynamic> map) {
    return ClienteFornecedorModel(
      id: map['id'] as int?,
      nome: map['nome'] as String?,
      fantasia: map['fantasia'] as String?,
      telefone: map['telefone'] as String?,
      cpfCnpj: map['cpf_cnpj'] as String?,
      estado: map['estado'] as String?,
      cep: map['cep'] as String?,
      cidade: map['cidade'] as String?,
      bairro: map['bairro'] as String?,
      endereco: map['endereco'] as String?,
      numero: map['numero'] as String?,
      complemento: map['complemento'] as String?,
      observacoes: map['observacoes'] as String?,
      ativo: map['ativo'] as bool?,
    );
  }

  @override
  String toString() {
    return 'ClienteFornecedorModel(id: $id, nome: $nome, fantasia: $fantasia, telefone: $telefone, cpfCnpj: $cpfCnpj, estado: $estado, cep: $cep, cidade: $cidade, bairro: $bairro, endereco: $endereco, numero: $numero, complemento: $complemento, observacoes: $observacoes, ativo: $ativo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClienteFornecedorModel &&
        other.id == id &&
        other.nome == nome &&
        other.fantasia == fantasia &&
        other.telefone == telefone &&
        other.cpfCnpj == cpfCnpj &&
        other.estado == estado &&
        other.cep == cep &&
        other.cidade == cidade &&
        other.bairro == bairro &&
        other.endereco == endereco &&
        other.numero == numero &&
        other.complemento == complemento &&
        other.observacoes == observacoes &&
        other.ativo == ativo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        fantasia.hashCode ^
        telefone.hashCode ^
        cpfCnpj.hashCode ^
        estado.hashCode ^
        cep.hashCode ^
        cidade.hashCode ^
        bairro.hashCode ^
        endereco.hashCode ^
        numero.hashCode ^
        complemento.hashCode ^
        observacoes.hashCode ^
        ativo.hashCode;
  }
}
