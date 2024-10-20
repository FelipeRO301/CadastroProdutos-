import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:produtos_mobile_2/constants/Endpoints.dart';
import '../model/fornecedor_model.dart';

class FornecedorController {
  final String baseUrl = Endpoints.fornecedores;
  final List<Fornecedor> _fornecedores = [];

  Future<List<Fornecedor>> getFornecedores() async {
    final response = await http.get(Uri.parse(baseUrl));
    _fornecedores.clear();
    if (response.statusCode == 200) {
      if (response.body == "null") {
        return _fornecedores;
      }
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((id, dados) {
        _fornecedores.add(Fornecedor(
          id: id,
          nome: dados['nome'],
          endereco: dados['endereco'],
        ));
      });
      return _fornecedores;
    } else {
      throw Exception("Erro ao buscar fornecedores");
    }
  }

  Future<void> addFornecedor(Fornecedor fornecedor) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(fornecedor.toJson()),
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar o fornecedor');
    }
  }

  Future<void> updateFornecedor(Fornecedor fornecedor) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${fornecedor.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(fornecedor.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar o fornecedor');
    }
  }

  Future<void> deleteFornecedor(String fornecedorId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$fornecedorId'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar o fornecedor');
    }
  }
}
