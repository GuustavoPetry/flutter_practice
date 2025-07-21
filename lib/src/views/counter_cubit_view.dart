import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void reset() => emit(0);
}

class CounterCubitView extends StatelessWidget {
  const CounterCubitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, count) {
            return Text("Valor: $count");
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: "increment",
            onPressed: () => context.read<CounterCubit>().increment(),
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: "decrement",
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: Icon(Icons.remove),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: "reset",
            onPressed: () => context.read<CounterCubit>().reset(),
            child: Icon(Icons.restore),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
