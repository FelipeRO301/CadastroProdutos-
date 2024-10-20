import 'package:flutter/material.dart';
import '../model/produto_model.dart';
import '../controllers/produto_controller.dart';
import 'produto_form.dart';

class ProdutoList extends StatefulWidget {
  @override
  _ProdutoListState createState() => _ProdutoListState();
}

class _ProdutoListState extends State<ProdutoList> {
  final ProdutoController _controller = ProdutoController();
  late Future<List<Produto>> _produtos;

  @override
  void initState() {
    super.initState();
    _produtos = _controller.getProdutos();
  }

  Future<void> _refreshList() async {
    setState(() {
      _produtos = _controller.getProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProdutoForm()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Produto>>(
        future: _produtos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar produtos.'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum produto encontrado.'));
          }

          return RefreshIndicator(
            onRefresh: _refreshList,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final produto = snapshot.data![index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle:
                      Text('Preço: R\$ ${produto.preco.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProdutoForm(produto: produto),
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
