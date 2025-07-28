import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utilidades/src/models/menu_model.dart';
import 'package:utilidades/src/views/about_view.dart';
import 'package:utilidades/src/views/alunos_view.dart';
import 'package:utilidades/src/views/bloc_example_view.dart';
import 'package:utilidades/src/views/converter_view.dart';
import 'package:utilidades/src/views/counter_cubit_view.dart';
import 'package:utilidades/src/views/firebase_messaging.dart';
import 'package:utilidades/src/views/home_view.dart';
import 'package:utilidades/src/views/login_river_view.dart';
import 'package:utilidades/src/views/person_view.dart';
import 'package:utilidades/src/views/products_list_view.dart';
import 'package:utilidades/src/views/riverpod_example_view.dart';

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

  MenuModel(
    title: "Pessoas (SQLite)",
    icon: Icons.person,
    route: "/person",
    page: PersonView(),
  ),

  MenuModel(
    title: "Riverpod Exemplo",
    icon: Icons.play_lesson,
    route: "/riverpod",
    page: ProviderScope(child: RiverpodExample()),
  ),

  MenuModel(
    title: "Login River Exemplo",
    icon: Icons.login,
    route: "/login-river",
    page: ProviderScope(child: LoginRiverView()),
  ),

  MenuModel(
    title: "Contador Bloc",
    icon: Icons.countertops,
    route: "/counter-bloc",
    page: BlocExampleView(),
  ),

  MenuModel(
    title: "Bloc + Cubit",
    icon: Icons.control_point_duplicate_rounded,
    route: "/bloc-cubit",
    page: BlocProvider(
      create: (_) => CounterCubit(),
      child: CounterCubitView(),
    ),
  ),

  MenuModel(
    title: "Crud Alunos",
    icon: Icons.class_,
    route: "/alunos",
    page: AlunosView(),
  ),

  MenuModel(
    title: "Firebase Messaging",
    icon: Icons.message,
    route: "/firebase-messaging",
    page: FirebaseCloudMessaging(),
  ),
];
