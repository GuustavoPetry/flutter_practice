import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:utilidades/src/controllers/product_controller.dart';
import 'package:utilidades/src/models/product_model.dart';
import 'package:utilidades/src/views/product_form.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({super.key});

  @override
  State<ProductsListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductsListView> {
  final _controller = ProductController();
  late Future<List<ProductModel>> _produtos;
  final currencyFormat = NumberFormat.simpleCurrency(locale: "pt-BR"); // formata antes de exibir

  @override
  void initState() {
    super.initState();
    _loadProdutos();
  }

  void _loadProdutos() {
    setState(() {
      _produtos = _controller.getAll(context);
    });
  }

  void openForm({ProductModel? produto}) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (_) => ProductForm(produto: produto, controller: _controller),
    );

    if (resultado == true) {
      _loadProdutos();
    }
  }

  void deleteProduct(int id) async {
    final confirm = await showDialog<bool>(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Deseja excluir este item?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancelar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Excluir")),
        ],
      )
    );
    if(confirm == true) {
      await _controller.delete(id);
      _loadProdutos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductModel>>(
        future: _produtos,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum produto encontrado"));
          }

          final produtos = snapshot.data!;

          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (_, i) {
              final p = produtos[i];
              return ListTile(
                title: Text(p.nome),
                subtitle: Text("Preço: ${currencyFormat.format(p.preco)}\nDescrição: ${p.descricao}"),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => openForm(produto: p),
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        if (p.id != null) {
                          deleteProduct(p.id!);
                        }
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
