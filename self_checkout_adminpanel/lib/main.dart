import 'package:flutter/material.dart';
import 'package:self_checkout_adminpanel/views/AddStoreView.dart';
import 'package:self_checkout_adminpanel/views/StatsView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Panel - Self Checkout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.white, primary: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Panel - Self Checkout'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Statistics'),
              Tab(text: 'Add Store'),
            ],
          ),
        ),
        body: TabBarView(
          children: [StatsView(), AddStoreView()],
        ),
      ),
    );
  }
}
