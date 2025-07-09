import 'package:flutter/material.dart';
import 'package:manager_app/core/database/db_service.dart';

class InfoEmpresaModel {
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
  final Image? logo;
  final String? senhaMestre;

  const InfoEmpresaModel({
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
    this.logo,
    this.senhaMestre,
  });

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
      'logo': logo,
      'senha_mestre': senhaMestre,
    };
  }

  factory InfoEmpresaModel.fromMap(Map<String, dynamic> map) {
    return InfoEmpresaModel(
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
      logo: map['logo'] != null ? Image.memory(map['logo']) : null,
      senhaMestre: map['senha_mestre'] as String?,
    );
  }

  @override
  String toString() {
    return 'InfoEmpresaModel(id: $id, nome: $nome, fantasia: $fantasia, telefone: $telefone, cpfCnpj: $cpfCnpj, estado: $estado, cep: $cep, cidade: $cidade, bairro: $bairro, endereco: $endereco, numero: $numero, complemento: $complemento, observacoes: $observacoes)';
  }
}

Future<InfoEmpresaModel> buscarInfoEmpresa() async {
  try {
    final db = await DbService().connection;
    final resultadosQuery = await db.execute('SELECT * FROM info_empresa');
    return resultadosQuery
        .map((row) {
          return InfoEmpresaModel.fromMap(row.toColumnMap());
        })
        .toList()
        .single;
  } catch (e) {
    throw Exception('$e');
  }
}
