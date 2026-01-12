class GalleryItem {
  final int id;
  final String titulo;
  final String imageUrl;
  final String autor;

  GalleryItem({
    required this.id,
    required this.titulo,
    required this.imageUrl,
    required this.autor,
  });

  factory GalleryItem.fromMap(Map<String, dynamic> map) {
    return GalleryItem(
      id: map['id'],
      titulo: map['titulo'],
      imageUrl: map['imageUrl'],
      autor: map['autor'],
    );
  }
}
