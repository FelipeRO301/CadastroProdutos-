import 'package:flutter/material.dart';
import 'produto_form.dart';
import 'produto_list.dart';

class ProdutoDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard de Produtos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProdutoForm()),
                );
              },
              child: Text('Adicionar Novo Produto'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProdutoList()),
                );
              },
              child: Text('Lista de Produtos'),
            ),
          ],
        ),
      ),
    );
  }
}
