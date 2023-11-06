class Chirp {
  int id;
  int authorId;
  String content;

  Chirp({required this.id, required this.authorId, required this.content});

  factory Chirp.fromJson(Map<String, dynamic> json) {
    return Chirp(
      id: json['id'],
      content: json['content'],
      authorId: json['authorId'],
    );
  }
}
