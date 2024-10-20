import 'package:flutter/material.dart';
import '../model/fornecedor_model.dart';
import '../controllers/fornecedor_controller.dart';

class FornecedorForm extends StatefulWidget {
  final Fornecedor? fornecedor;
  const FornecedorForm({Key? key, this.fornecedor}) : super(key: key);

  @override
  _FornecedorFormState createState() => _FornecedorFormState();
}

class _FornecedorFormState extends State<FornecedorForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final FornecedorController _controller = FornecedorController();

  @override
  void initState() {
    super.initState();
    if (widget.fornecedor != null) {
      _nomeController.text = widget.fornecedor!.nome;
      _enderecoController.text = widget.fornecedor!.endereco;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final fornecedor = Fornecedor(
        id: widget.fornecedor?.id ?? '',
        nome: _nomeController.text,
        endereco: _enderecoController.text,
      );

      if (widget.fornecedor == null) {
        await _controller.addFornecedor(fornecedor);
      } else {
        await _controller.updateFornecedor(fornecedor);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fornecedor == null
            ? 'Novo Fornecedor'
            : 'Editar Fornecedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _enderecoController,
                decoration: InputDecoration(labelText: 'Endereço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o endereço';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
