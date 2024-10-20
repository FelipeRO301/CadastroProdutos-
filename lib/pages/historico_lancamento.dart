import 'package:flutter/material.dart';
import 'package:produtos_mobile_2/controllers/lacamento_controller.dart';
import 'package:produtos_mobile_2/model/lacamento_model.dart';
import 'lancamento_list.dart';

class HistoricoLancamento extends StatefulWidget {
  const HistoricoLancamento({super.key});

  @override
  _HistoricoLancamentoState createState() => _HistoricoLancamentoState();
}

class _HistoricoLancamentoState extends State<HistoricoLancamento> {
  final LancamentoController _lancamentoController = LancamentoController();
  Future<List<Lancamento>>? _lancamentos;

  @override
  void initState() {
    super.initState();
    _lancamentos = _lancamentoController.getLancamentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico de Lançamentos"),
      ),
      body: FutureBuilder<List<Lancamento>>(
        future: _lancamentos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else {
            return LancamentoList(lancamentos: snapshot.data!);
          }
        },
      ),
    );
  }
}
