import 'package:bluebaker/exports.dart';

class Collection extends Equatable {
  const Collection({
    required this.id,
    required this.photoUrl,
    required this.title,
  });

  final String id;
  final String photoUrl;
  final String title;

  @override
  List<Object?> get props => [id, photoUrl, title];

  Collection copyWith({
    String? id,
    String? photoUrl,
    String? title,
  }) {
    return Collection(
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'photoUrl': photoUrl,
      'id': id,
    };
  }

  factory Collection.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Collection(
      id: data['id'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      title: data['title'] ?? '',
    );
  }
}
