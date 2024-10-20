import 'package:flutter/material.dart';
import 'gestor_dashboard.dart';
import 'fornecedor_dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bem-vindo ao Sistema de Gestão!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GestorDashboard()),
                );
              },
              child: const Text('Dashboard do Gestor'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FornecedorDashboard()),
                );
              },
              child: const Text('Dashboard do Fornecedor'),
            ),
          ],
        ),
      ),
    );
  }
}
