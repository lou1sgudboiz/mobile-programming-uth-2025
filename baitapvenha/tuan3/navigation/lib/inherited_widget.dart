import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Data được chia sẻ
class CounterData {
  final int counter;
  final VoidCallback increment;

  CounterData({required this.counter, required this.increment});
}

class CounterProvider extends InheritedWidget {
  final CounterData data;

  const CounterProvider({
    super.key,
    required this.data,
    required Widget myChild,
  }) : super(child: myChild);

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return oldWidget.data.counter != data.counter;
  }
}

/// App gốc
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InheritedWidget Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CounterWrapper(),
    );
  }
}

/// StatefulWidget giữ state và tạo InheritedWidget
class CounterWrapper extends StatefulWidget {
  const CounterWrapper({super.key});

  @override
  State<CounterWrapper> createState() => _CounterWrapperState();
}

class _CounterWrapperState extends State<CounterWrapper> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      data: CounterData(counter: _counter, increment: _increment),
      myChild: const HomePage(),
    );
  }
}

/// Widget con dùng dữ liệu từ CounterProvider
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterData = CounterProvider.of(context)!.data;

    return Scaffold(
      appBar: AppBar(title: const Text("InheritedWidget Example")),
      body: Center(
        child: Text(
          "Counter: ${counterData.counter}",
          style: const TextStyle(fontSize: 32),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterData.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
