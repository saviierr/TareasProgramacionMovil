// lib/features/ar_experience/presentation/screens/ar_screen.dart
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArScreen extends StatefulWidget {
  const ArScreen({super.key});

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Astronauta'),
        backgroundColor: Colors.black,
      ),
      body: ARView(
        // 0.7.3 pide 4 parámetros → le damos los 4 (el último es ignorado)
        onARViewCreated:
            (
              ARSessionManager sessionManager,
              ARObjectManager objectManager,
              ARAnchorManager anchorManager,
              dynamic locationManager, // puede ser ARLocationManager o null
            ) {
              arSessionManager = sessionManager;
              arObjectManager = objectManager;

              arSessionManager!.onInitialize(
                showFeaturePoints: false,
                showPlanes: true,
                customPlaneTexturePath: "assets/images/triangle.png",
                showWorldOrigin: false,
              );

              // Esta es la firma correcta en 0.7.3
              arSessionManager!.onPlaneOrPointTap = onPlaneTapped;
            },
      ),
    );
  }

  // Esta es la firma EXACTA que espera ar_flutter_plugin 0.7.3
  Future<void> onPlaneTapped(List<dynamic> hits) async {
    if (hits.isEmpty) return;

    final hit = hits.first;

    final newNode = ARNode(
      type: NodeType.webGLB,
      uri: "https://modelviewer.dev/shared-assets/models/Astronaut.glb",
      scale: vector.Vector3(0.35, 0.35, 0.35),
      position: vector.Vector3(0, 0, 0),
    );

    // addNode sin parámetros extra en esta versión
    await arObjectManager!.addNode(newNode);
  }

  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }
}
