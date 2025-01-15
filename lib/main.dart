import 'package:flutter/material.dart';
import 'package:mongoo/screen/insert.dart';
import 'package:mongoo/service/mongoservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Mongoservice.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Insert(),
    );
  }
}
