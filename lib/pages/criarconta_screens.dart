import 'package:flutter/material.dart';
import 'package:produtos_mobile_2/controllers/usuario_controller.dart';
import 'package:produtos_mobile_2/model/usuario_model.dart';

class CriarContaScreen extends StatefulWidget {
  @override
  _CriarContaScreenState createState() => _CriarContaScreenState();
}

class _CriarContaScreenState extends State<CriarContaScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final UsuarioController _usuarioController = UsuarioController();

  String _errorMessage = '';

  Future<void> _criarConta() async {
    String nome = _nomeController.text.trim();
    String email = _emailController.text.trim();
    String senha = _senhaController.text.trim();

    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, preencha todos os campos';
      });
      return;
    }

    try {
      Usuario novoUsuario = Usuario(
        id: '',
        nome: nome,
        email: email,
        senha: senha,
      );

      await _usuarioController.adicionarUsuario(novoUsuario);

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao criar conta. Tente novamente mais tarde.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _criarConta,
              child: const Text('Criar Conta'),
            ),
            const SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Text(_errorMessage, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
