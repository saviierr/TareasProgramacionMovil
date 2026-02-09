import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_resilencia/core/network/dio_client.dart';
import 'package:app_resilencia/providers/post_provider.dart';
import 'package:app_resilencia/screens/home_screen.dart';

void main() {
  // Initialize Dio client with interceptor
  DioClient().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostProvider(),
      child: MaterialApp(
        title: 'App Resiliente',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
