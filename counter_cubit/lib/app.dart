import 'package:flutter/material.dart';
import 'package:flutter_counter/counter_cubit/view/counter_page.dart';

class CounterApp extends MaterialApp {
  const CounterApp({super.key})
      : super(
          home: const CounterPage(),
        );
}
