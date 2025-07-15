import 'package:flutter/material.dart';
import 'package:utilidades/src/models/menu_model.dart';
import 'package:utilidades/src/views/about_view.dart';
import 'package:utilidades/src/views/converter_view.dart';
import 'package:utilidades/src/views/home_view.dart';
import 'package:utilidades/src/views/products_list_view.dart';

final List<MenuModel> appMenuItems = [
  MenuModel(
    title: "Home",
    icon: Icons.home,
    route: "/home",
    page: const HomeView(),
  ),

  MenuModel(
    title: "Sobre Mim",
    icon: Icons.person_sharp,
    route: "/about",
    page: AboutView(),
  ),

  MenuModel(
    title: "Conversor de Medidas",
    icon: Icons.design_services,
    route: "/converter",
    page: ConverterView(),
  ),

  MenuModel(
    title: "Produtos",
    icon: Icons.production_quantity_limits,
    route: "/produtos",
    page: ProductsListView(),
  ),
];
