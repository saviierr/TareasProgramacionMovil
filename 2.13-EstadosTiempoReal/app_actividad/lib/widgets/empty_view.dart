import 'package:flutter/material.dart';

/// Empty view widget displayed when the API returns an empty list
///
/// Shows:
/// - Inbox icon
/// - "No hay publicaciones" message
class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Inbox icon
            Icon(Icons.inbox, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),

            // Empty state title
            Text(
              'No hay publicaciones',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Empty state message
            Text(
              'No se encontraron publicaciones disponibles en este momento.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
