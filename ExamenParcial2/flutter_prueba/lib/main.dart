import 'package:flutter/material.dart';
import 'screens/galeria_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Galería desde SQLite',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: GaleriaSQLiteScreen(),
    );
  }
}
