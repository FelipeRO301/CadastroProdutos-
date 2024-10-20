import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:produtos_mobile_2/constants/Endpoints.dart';
import 'package:produtos_mobile_2/model/usuario_model.dart';

class UsuarioController {
  final String baseUrl = Endpoints.usuarios;
  final List<Usuario> _usuarios = [];

  Future<List<Usuario>> getUsuarios() async {
    final response = await http.get(Uri.parse(baseUrl));
    _usuarios.clear();
    if (response.statusCode == 200) {
      if (response.body == "null") {
        return _usuarios;
      }
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((usuarioId, usuario) {
        _usuarios.add(Usuario(
          id: usuarioId,
          nome: usuario['nome'],
          email: usuario['email'],
          senha: usuario["senha"],
        ));
      });
      return _usuarios;
    } else {
      throw Exception("Erro ao buscar usuarios");
    }
  }

  Future<void> adicionarUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(usuario.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao adicionar usuário');
    }
  }
}
