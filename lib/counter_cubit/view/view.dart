import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/counter_cubit/cubit/counter_cubit.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Try Counter',
            style:
                TextStyle(fontSize: 24, color: Colors.black)), // Judul aplikasi
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text('$state', style: TextStyle(fontSize: 36));
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
              key: const Key('counterView_increment_fab'),
              child: const Icon(Icons.add),
              onPressed: () {
                context.read<CounterCubit>().increment();
              }),
          SizedBox(height: 15),
          FloatingActionButton(
              key: const Key('counterView_decrement_fab'),
              child: const Icon(Icons.remove),
              onPressed: () {
                context.read<CounterCubit>().decrement();
              }),
          SizedBox(height: 15),
          FloatingActionButton(
              key: const Key('counterView_multiply_fab'),
              child: const Icon(Icons.clear),
              onPressed: () {
                context.read<CounterCubit>().multiply();
              }),
          SizedBox(height: 15),
          FloatingActionButton(
              key: const Key('counterView_minus_fab'),
              child: const Icon(Icons.exposure_minus_2),
              onPressed: () {
                context.read<CounterCubit>().minus();
              }),
          SizedBox(height: 15),
          FloatingActionButton(
              key: const Key('counterView_reset_fab'),
              child: const Icon(Icons.restore),
              onPressed: () {
                context.read<CounterCubit>().reset();
              }),
        ],
      ),
    );
  }
}
