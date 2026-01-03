import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clase de Flutter: ARsss e IA'),
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Selecciona una demostración',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // Botón para ir a Model Viewer (3D simple)
              _MenuButton(
                icon: Icons.view_in_ar,
                label: 'Visualizador 3D (Model Viewer)',
                onPressed: () => context.goNamed('model_viewer'),
              ),
              const SizedBox(height: 20),

              // Botón para ir a AR Flutter Plugin (AR Core/Kit)
              _MenuButton(
                icon: Icons.layers,
                label: 'Realidad Aumentada (AR Plugin)',
                onPressed: () => context.goNamed('ar_experience'),
              ),
              const SizedBox(height: 20),

              // Botón para ir a Reconocimiento de Texto (ML Kit)
              _MenuButton(
                icon: Icons.text_snippet,
                label: 'Reconocimiento de Texto (OCR)',
                onPressed: () => context.goNamed('text_recognition'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 30),
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
