import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/text_widget.dart';

class ProdutosModel {
  final int? id;
  final String? codigo;
  final String? descricao;
  final double? custo;
  final double? venda;
  final double? estoque;
  final String? unidade;
  final String? observacoes;
  final bool? ativo;

  const ProdutosModel({
    this.id,
    this.codigo,
    this.descricao,
    this.custo,
    this.venda,
    this.estoque,
    this.unidade,
    this.observacoes,
    this.ativo = true,
  });

  ProdutosModel copyWith({
    int? id,
    String? codigo,
    String? descricao,
    double? custo,
    double? venda,
    double? estoque,
    String? unidade,
    String? observacoes,
    bool? ativo,
  }) {
    return ProdutosModel(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      custo: custo ?? this.custo,
      venda: venda ?? this.venda,
      estoque: estoque ?? this.estoque,
      unidade: unidade ?? this.unidade,
      observacoes: observacoes ?? this.observacoes,
      ativo: ativo ?? this.ativo,
    );
  }

  String getVendaFormatada() {
    if (venda == null) return 'R\$ 0,00';
    return 'R\$ ${venda!.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  String getCustoFormatado() {
    if (custo == null) return 'R\$ 0,00';
    return 'R\$ ${custo!.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo': codigo,
      'descricao': descricao,
      'custo': custo,
      'venda': venda,
      'estoque': estoque,
      'unidade': unidade,
      'observacoes': observacoes,
      'ativo': ativo,
    };
  }

  factory ProdutosModel.fromMap(Map<String, dynamic> map) {
    return ProdutosModel(
      id: map['id'] as int?,
      codigo: map['codigo'] as String?,
      descricao: map['descricao'] as String?,
      custo: double.parse(map['custo']),
      venda: double.parse(map['venda']),
      estoque: double.parse(map['estoque']),
      unidade: map['unidade'] as String?,
      observacoes: map['observacoes'] as String?,
      ativo: map['ativo'] as bool?,
    );
  }

  @override
  String toString() {
    return 'ProdutosModel(id: $id, descricao: $descricao, venda: $venda, estoque: $estoque $unidade, ativo: $ativo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProdutosModel &&
        other.id == id &&
        other.codigo == codigo &&
        other.descricao == descricao &&
        other.custo == custo &&
        other.venda == venda &&
        other.estoque == estoque &&
        other.unidade == unidade &&
        other.observacoes == observacoes &&
        other.ativo == ativo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        codigo.hashCode ^
        descricao.hashCode ^
        custo.hashCode ^
        venda.hashCode ^
        estoque.hashCode ^
        unidade.hashCode ^
        observacoes.hashCode ^
        ativo.hashCode;
  }
}
