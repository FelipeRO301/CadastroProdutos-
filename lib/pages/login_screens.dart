import 'package:flutter/material.dart';
import 'package:produtos_mobile_2/controllers/usuario_controller.dart';
import 'package:produtos_mobile_2/model/usuario_model.dart';
import 'package:produtos_mobile_2/pages/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final UsuarioController _usuarioController = UsuarioController();

  String? _errorMessage;

  Future<void> _login() async {
    String email = _emailController.text;
    String senha = _senhaController.text;

    try {
      List<Usuario> usuarios = await _usuarioController.getUsuarios();

      Usuario? usuarioEncontrado;
      for (var usuario in usuarios) {
        if (usuario.email == email && usuario.senha == senha) {
          usuarioEncontrado = usuario;
          break;
        }
      }

      if (usuarioEncontrado != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = 'Email ou senha incorretos';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao realizar login. Tente novamente mais tarde.';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Entrar'),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/criarconta');
              },
              child: const Text('Criar uma conta'),
            ),
          ],
        ),
      ),
    );
  }
}
