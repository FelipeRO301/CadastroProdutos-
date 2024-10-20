import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:produtos_mobile_2/constants/Endpoints.dart';
import 'package:produtos_mobile_2/model/lacamento_model.dart';

class LancamentoController {
  final String baseUrl = Endpoints.lancamentos;
  final List<Lancamento> _lancamentos = [];

  Future<List<Lancamento>> getLancamentos() async {
    final response = await http.get(Uri.parse(baseUrl));
    _lancamentos.clear();

    if (response.statusCode == 200) {
      if (response.body == "null") {
        return _lancamentos;
      }
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((id, lancamento) {
        _lancamentos.add(Lancamento(
          id: id,
          produtoId: lancamento['produtoId'],
          fornecedorId: lancamento['fornecedorId'],
          quantidade: lancamento['quantidade'],
          descricao: lancamento['descricao'],
          valor: (lancamento['valor'] as num).toDouble(),
          dataLancamento: DateTime.parse(lancamento['dataLancamento']),
        ));
      });
      return _lancamentos;
    } else {
      throw Exception("Erro ao buscar lançamentos");
    }
  }

  Future<void> addLancamento(Lancamento lancamento) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(lancamento.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar o lançamento');
    }
  }

  Future<void> updateLancamento(Lancamento lancamento) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${lancamento.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(lancamento.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar o lançamento');
    }
  }

  Future<void> deleteLancamento(String lancamentoId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$lancamentoId'));

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar o lançamento');
    }
  }
}
