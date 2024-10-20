import 'package:produtos_mobile_2/constants/Endpoints.dart';

class Fornecedor {
  final String id;
  final String nome;
  final String endereco;

  Fornecedor({
    required this.id,
    required this.nome,
    required this.endereco,
  });

  factory Fornecedor.fromJson(Map<String, dynamic> json) {
    return Fornecedor(
      id: json['id'],
      nome: json['nome'],
      endereco: json['endereco'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
    };
  }

  String get fornecedorUrl => '$baseUrl/fornecedores/$id';
}
