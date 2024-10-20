import 'package:produtos_mobile_2/constants/Endpoints.dart';

class Produto {
  final String id;
  final String nome;
  final double preco;
  final String fornecedorId;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.fornecedorId,
    required descricao,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      preco: json['preco'],
      fornecedorId: json['fornecedorId'],
      descricao: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
      'fornecedorId': fornecedorId,
    };
  }

  String get produtoUrl => '$baseUrl/produtos/$id';
}
