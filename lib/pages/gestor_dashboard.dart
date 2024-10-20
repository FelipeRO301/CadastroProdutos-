import 'package:flutter/material.dart';
import 'fornecedor_dashboard.dart';
import 'produto_dashboard.dart';
import 'lancamento_dashboard.dart';

class GestorDashboard extends StatelessWidget {
  const GestorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard do Gestor"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FornecedorDashboard()),
                );
              },
              child: const Text("Gerenciar Fornecedores"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdutoDashboard()),
                );
              },
              child: const Text("Gerenciar Produtos"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LancamentoDashboard()),
                );
              },
              child: const Text("Gerenciar Lançamentos"),
            ),
          ],
        ),
      ),
    );
  }
}
