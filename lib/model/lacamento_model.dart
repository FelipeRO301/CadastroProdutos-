class Lancamento {
  final String id;
  final String descricao;
  final double valor;
  final String produtoId;
  final String fornecedorId;
  final double quantidade;
  final DateTime dataLancamento;

  Lancamento(
      {required this.id,
      required this.descricao,
      required this.valor,
      required this.produtoId,
      required this.fornecedorId,
      required this.quantidade,
      required this.dataLancamento});

  factory Lancamento.fromJson(Map<String, dynamic> json) {
    return Lancamento(
      id: json['id'],
      descricao: json['descricao'],
      valor: json['valor'].toDouble(),
      produtoId: json['produtoId'],
      fornecedorId: json['fornecedorId'],
      quantidade: json['quantidade'],
      dataLancamento: json['dataLancamento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'dataLancamento': dataLancamento.toString(),
      'quantidade': quantidade,
      "produtoId": produtoId,
      'fornecedorId': fornecedorId
    };
  }
}
