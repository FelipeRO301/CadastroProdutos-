import 'package:flutter/material.dart';
import 'lancamento_form.dart';
import 'historico_lancamento.dart';

class LancamentoDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard de Lançamentos"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LancamentoForm()),
                );
              },
              child: Text("Adicionar Lançamento"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoricoLancamento()),
                );
              },
              child: Text("Ver Histórico de Lançamentos"),
            ),
          ],
        ),
      ),
    );
  }
}
