import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BlueBaker extends Equatable {
  const BlueBaker({
    required this.id,
    // required this.photoUrl,
    required this.title,
  });

  final String id;
  // final String photoUrl;
  final String title;

  @override
  List<Object?> get props => [id, /*photoUrl,*/ title];

  BlueBaker copyWith({
    String? id,
    // String? photoUrl,
    String? title,
  }) {
    return BlueBaker(
      id: id ?? this.id,
      // photoUrl: photoUrl ?? this.photoUrl,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      // 'photoUrl': photoUrl,
      'id': id,
    };
  }

  factory BlueBaker.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BlueBaker(
      id: data['id'] ?? '',
      // photoUrl: data['photoUrl'] ?? '',
      title: data['title'] ?? '',
    );
  }
}
