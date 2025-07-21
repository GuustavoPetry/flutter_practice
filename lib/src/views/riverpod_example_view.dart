import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider de controle de estado
final contadorProvider = StateProvider((ref) => 0);

// Uso na UI
class RiverpodExample extends ConsumerWidget {
  const RiverpodExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Substitui o SetState
    final contador = ref.watch(contadorProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Valor: $contador"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => ref.read(contadorProvider.notifier).state++,
                child: Icon(Icons.add),
              ),
              SizedBox(width: 15),
              ElevatedButton(
                onPressed: () => ref.read(contadorProvider.notifier).state--,
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 15),
              ElevatedButton(
                onPressed: () => ref.read(contadorProvider.notifier).state = 0,
                child: Icon(Icons.reset_tv),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
