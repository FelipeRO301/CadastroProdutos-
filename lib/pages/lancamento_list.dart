import 'package:flutter/material.dart';
import 'package:produtos_mobile_2/model/lacamento_model.dart';

class LancamentoList extends StatelessWidget {
  final List<Lancamento> lancamentos;

  const LancamentoList({required this.lancamentos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lancamentos.length,
      itemBuilder: (context, index) {
        final lancamento = lancamentos[index];
        return ListTile(
          title: Text(lancamento.descricao),
          subtitle: Text('Valor: R\$${lancamento.valor.toStringAsFixed(2)}'),
          trailing: Text('Quantidade: ${lancamento.quantidade}'),
          onTap: () {},
        );
      },
    );
  }
}
