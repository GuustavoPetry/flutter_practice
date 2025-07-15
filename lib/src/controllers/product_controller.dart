import 'package:flutter/widgets.dart';
import 'package:utilidades/src/models/product_model.dart';
import 'package:utilidades/src/services/product_service.dart';

class ProductController {
  final ProductService _service = ProductService();

  Future<List<ProductModel>> getAll(BuildContext context) => _service.getAll(context);

  Future<void> create(ProductModel produto) => _service.create(produto);

  Future<void> update(ProductModel produto) => _service.update(produto);

  Future<void> delete(int id) => _service.delete(id);
}