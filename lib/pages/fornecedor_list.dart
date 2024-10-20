import 'package:flutter/material.dart';
import '../model/fornecedor_model.dart';
import '../controllers/fornecedor_controller.dart';
import 'fornecedor_form.dart';

class FornecedorList extends StatefulWidget {
  @override
  _FornecedorListState createState() => _FornecedorListState();
}

class _FornecedorListState extends State<FornecedorList> {
  final FornecedorController _controller = FornecedorController();
  late Future<List<Fornecedor>> _fornecedores;

  @override
  void initState() {
    super.initState();
    _fornecedores = _controller.getFornecedores();
  }

  Future<void> _refreshList() async {
    setState(() {
      _fornecedores = _controller.getFornecedores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Fornecedores'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FornecedorForm()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Fornecedor>>(
        future: _fornecedores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar fornecedores.'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum fornecedor encontrado.'));
          }

          return RefreshIndicator(
            onRefresh: _refreshList,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final fornecedor = snapshot.data![index];
                return ListTile(
                  title: Text(fornecedor.nome),
                  subtitle: Text(fornecedor.endereco),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              FornecedorForm(fornecedor: fornecedor),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
