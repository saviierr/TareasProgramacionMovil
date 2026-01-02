import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/ocr_service.dart';
import '../parsers/invoice_parser.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  String statusMessage = 'Seleccione una imagen para escanear';

  // ============================
  // Selección desde cámara
  // ============================
  Future<void> scanFromCamera() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      await _processImage(File(image.path));
    }
  }

  // ============================
  // Selección desde galería
  // ============================
  Future<void> scanFromGallery() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      await _processImage(File(image.path));
    }
  }

  // ============================
  // OCR + Parsing (ASÍNCRONO)
  // ============================
  Future<void> _processImage(File imageFile) async {
    setState(() {
      isLoading = true;
      statusMessage = 'Procesando imagen...';
    });

    try {
      final rawText = await OcrService.extractText(imageFile);
      final invoiceData = InvoiceParser.parse(rawText);

      dateController.text = invoiceData.date ?? '';
      totalController.text =
          invoiceData.total?.toStringAsFixed(2) ?? '';
      codeController.text = invoiceData.invoiceCode ?? '';

      setState(() {
        statusMessage = 'Datos detectados correctamente';
      });
    } catch (e) {
      setState(() {
        statusMessage = 'Error al procesar la imagen';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // ============================
  // UI
  // ============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Invoice Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Estado / Mensaje
            Text(
              statusMessage,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 16),

            // Loading
            if (isLoading)
              const CircularProgressIndicator(),

            const SizedBox(height: 16),

            // Botones de captura
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Cámara'),
                  onPressed: isLoading ? null : scanFromCamera,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo),
                  label: const Text('Galería'),
                  onPressed: isLoading ? null : scanFromGallery,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Campos autopoblados (EDITABLES)
            TextFormField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Fecha de Emisión',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: totalController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Monto Total',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'Código de Factura',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // Botón Guardar (simulado)
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Factura guardada correctamente'),
                        ),
                      );
                    },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
