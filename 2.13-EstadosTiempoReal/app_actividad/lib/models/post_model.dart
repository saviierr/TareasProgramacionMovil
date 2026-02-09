class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      title: _validateString(json['title'] as String?, 'Sin título'),
      body: _validateString(json['body'] as String?, 'Sin contenido'),
    );
  }

  /// Helper method to validate strings and provide defaults
  static String _validateString(String? value, String defaultValue) {
    if (value == null || value.trim().isEmpty) {
      return defaultValue;
    }
    return value;
  }

  /// Converts Post to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'userId': userId, 'title': title, 'body': body};
  }

  @override
  String toString() {
    return 'Post(id: $id, userId: $userId, title: $title)';
  }
}
