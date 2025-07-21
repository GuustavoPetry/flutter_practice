import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utilidades/src/controllers/login_river_controller.dart';
import 'package:utilidades/src/models/login_state.dart';

final loginProvider = StateNotifierProvider<LoginRiverController, LoginState>(
  (ref) => LoginRiverController(),
);
