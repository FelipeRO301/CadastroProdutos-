import 'package:flutter/material.dart';
import 'package:produtos_mobile_2/controllers/lacamento_controller.dart';
import 'package:produtos_mobile_2/controllers/fornecedor_controller.dart';
import 'package:produtos_mobile_2/controllers/produto_controller.dart';
import 'package:produtos_mobile_2/model/lacamento_model.dart';
import 'package:produtos_mobile_2/model/fornecedor_model.dart';
import 'package:produtos_mobile_2/model/produto_model.dart';

class LancamentoForm extends StatefulWidget {
  const LancamentoForm({super.key});

  @override
  _LancamentoFormState createState() => _LancamentoFormState();
}

class _LancamentoFormState extends State<LancamentoForm> {
  final LancamentoController _lancamentoController = LancamentoController();
  final FornecedorController _fornecedorController = FornecedorController();
  final ProdutoController _produtoController = ProdutoController();

  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _dataLancamentoController =
      TextEditingController(); // Controller para a data

  String? produtoId;
  String? fornecedorId;
  List<Fornecedor> _fornecedores = [];
  List<Produto> _produtos = [];
  DateTime? dataLancamento; // Variável para armazenar a data selecionada

  @override
  void initState() {
    super.initState();
    _fetchFornecedores();
    _fetchProdutos();
  }

  Future<void> _fetchFornecedores() async {
    _fornecedores = await _fornecedorController.getFornecedores();
    setState(() {});
  }

  Future<void> _fetchProdutos() async {
    _produtos = await _produtoController.getProdutos();
    setState(() {});
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    _quantidadeController.dispose();
    _dataLancamentoController.dispose(); // Dispose do controlador da data
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataLancamento ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dataLancamento) {
      setState(() {
        dataLancamento = picked;
        _dataLancamentoController.text =
            "${picked.toLocal()}".split(' ')[0]; // Formato YYYY-MM-DD
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final lancamento = Lancamento(
        id: '',
        produtoId: produtoId!,
        fornecedorId: fornecedorId!,
        quantidade: double.parse(_quantidadeController.text),
        descricao: _descricaoController.text,
        valor: double.parse(_valorController.text),
        dataLancamento: dataLancamento ??
            DateTime.now(), // Usa a data selecionada ou a atual
      );

      print(lancamento.toJson());
      await _lancamentoController.addLancamento(lancamento);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Lançamento"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Fornecedor'),
                value: fornecedorId,
                onChanged: (value) {
                  setState(() {
                    fornecedorId = value;
                  });
                },
                items: _fornecedores.map((fornecedor) {
                  return DropdownMenuItem<String>(
                    value: fornecedor.id,
                    child: Text(fornecedor.nome),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um fornecedor';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Produto'),
                value: produtoId,
                onChanged: (value) {
                  setState(() {
                    produtoId = value;
                  });
                },
                items: _produtos.map((produto) {
                  return DropdownMenuItem<String>(
                    value: produto.id,
                    child: Text(produto.nome),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um produto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe a descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o valor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantidadeController,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe a quantidade';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Informe um número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dataLancamentoController,
                decoration:
                    const InputDecoration(labelText: 'Data do Lançamento'),
                readOnly: true, // Torna o campo somente leitura
                onTap: () {
                  _selectDate(
                      context); // Chama o seletor de data quando o campo é tocado
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe a data do lançamento';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Adicionar Lançamento"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
