import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:produtos_mobile_2/constants/Endpoints.dart';
import '../model/produto_model.dart';

class ProdutoController {
  final String baseUrl = Endpoints.produtos;
  final List<Produto> _produtos = [];

  Future<List<Produto>> getProdutos() async {
    final response = await http.get(Uri.parse(baseUrl));
    _produtos.clear();

    if (response.statusCode == 200) {
      if (response.body == "null") {
        return _produtos;
      }
      print(response.body);
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((id, produto) {
        _produtos.add(Produto(
          id: id,
          nome: produto['nome'],
          descricao: produto['descricao'],
          preco: (produto['preco'] != null)
              ? (produto['preco'] as num).toDouble()
              : 0.0,
          fornecedorId: produto['fornecedorId'],
        ));
      });
      return _produtos;
    } else {
      throw Exception("Erro ao buscar produtos");
    }
  }

  Future<void> addProduto(Produto produto) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(produto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar o produto');
    }
  }

  Future<void> updateProduto(Produto produto) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${produto.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(produto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar o produto');
    }
  }

  Future<void> deleteProduto(String produtoId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$produtoId'));

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar o produto');
    }
  }
}
