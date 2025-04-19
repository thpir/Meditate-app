import 'package:flutter/material.dart';
import 'package:meditate_app/ui/home/widgets/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Nunito'),
      home: HomeScreen(),
    );
  }
}
