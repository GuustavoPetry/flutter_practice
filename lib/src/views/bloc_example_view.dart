import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvents {}

class IncrementEvent extends CounterEvents {}

class DecrementEvent extends CounterEvents {}

class ResetEvent extends CounterEvents {}

class CounterState {
  int counter;
  CounterState(this.counter);
}

class CounterBloc extends Bloc<CounterEvents, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<IncrementEvent>((event, emit) {
      emit(CounterState(state.counter + 1));
    });

    on<DecrementEvent>((event, emit) {
      emit(CounterState(state.counter - 1));
    });

    on<ResetEvent>((event, emit) {
      emit(CounterState(state.counter = 0));
    });
  }
}

class BlocExampleView extends StatelessWidget {
  const BlocExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Builder(
        // Este Builder fornece um novo BuildContext
        builder: (context) {
          return Scaffold(
            body: Center(
              child: BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  return Text(
                    "Contador: ${state.counter}",
                    style: TextStyle(fontSize: 22),
                  );
                },
              ),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () => {
                    context.read<CounterBloc>().add(IncrementEvent()),
                  },
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () => {
                    context.read<CounterBloc>().add(DecrementEvent()),
                  },
                  child: Icon(Icons.remove),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "btn3",
                  onPressed: () => {
                    context.read<CounterBloc>().add(ResetEvent()),
                  },
                  child: Icon(Icons.reset_tv),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
