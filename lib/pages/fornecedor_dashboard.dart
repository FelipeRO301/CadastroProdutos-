import 'package:flutter/material.dart';
import 'fornecedor_form.dart';
import 'fornecedor_list.dart';

class FornecedorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard de Fornecedores'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FornecedorForm()),
                );
              },
              child: Text('Adicionar Novo Fornecedor'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FornecedorList()),
                );
              },
              child: Text('Lista de Fornecedores'),
            ),
          ],
        ),
      ),
    );
  }
}
