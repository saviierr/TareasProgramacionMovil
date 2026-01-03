import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/ar_experience/presentation/screens/ar_screen.dart';
import '../../features/ar_experience/presentation/screens/model_viewer_screen.dart'; // Added this
import '../../features/text_recognition/presentation/screens/text_recognition_screen.dart';

/// Configuración del Router usando GoRouter
///
/// Esto define todas las rutas de la aplicación y cómo se navega entre ellas.
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    /// Ruta principal (Home)
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        /// Ruta para la experiencia AR con ar_flutter_plugin
        GoRoute(
          path: 'ar',
          name: 'ar_experience',
          builder: (context, state) => const ArScreen(),
        ),

        /// Ruta para ver modelos 3D con model_viewer_plus
        GoRoute(
          path: 'model_viewer',
          name: 'model_viewer',
          builder: (context, state) => const ModelViewerScreen(),
        ),

        /// Ruta para el reconocimiento de texto
        GoRoute(
          path: 'text_recognition',
          name: 'text_recognition',
          builder: (context, state) => const TextRecognitionScreen(),
        ),
      ],
    ),
  ],
);
