import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../database/db_helper.dart';
import '../models/galeria_item.dart';

class GaleriaSQLiteScreen extends StatelessWidget {
  GaleriaSQLiteScreen({super.key});

  final String autor = 'SST-7';

  Future<List<GalleryItem>> _loadItems() async {
    final data = await DBHelper.getByAutor(autor);
    return data.map((e) => GalleryItem.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galería desde SQLite')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Autor: $autor',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<GalleryItem>>(
              future: _loadItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay datos'));
                }

                final items = snapshot.data!;

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: item.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(strokeWidth: 2),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.broken_image),
                        ),
                        title: Text(item.titulo),
                        subtitle: Text(item.autor),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
