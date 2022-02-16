import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String name;
  final String email;
  final String profileImageUrl;
  final String country;
  final String telephone;
  final Timestamp joined;

  const User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.country,
    required this.telephone,
    required this.joined,
  });

  //static const empty = User()
  static var empty = User(
    id: '',
    username: '',
    name: '',
    email: '',
    profileImageUrl: '',
    country: '',
    telephone: '',
    joined: Timestamp.now(),
  );

  @override
  List<Object?> get props => [
        id,
        username,
        name,
        email,
        profileImageUrl,
        country,
        telephone,
        joined,
      ];

  User copyWith({
    String? id,
    String? username,
    String? name,
    String? email,
    String? profileImageUrl,
    String? country,
    String? telephone,
    Timestamp? joined,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      country: country ?? this.country,
      telephone: telephone ?? this.telephone,
      joined: joined ?? this.joined,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'country': country,
      'telephone': telephone,
      'joined': joined,
    };
  }

  // factory User.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
  //   if (doc.data() != null) {
  //     Map<String, dynamic>? data = doc.data()!;
  //     return User(
  //       id: doc.id,
  //       username: data['username'] ?? '',
  //       name: data['name'] ?? '',
  //       email: data['email'] ?? '',
  //       profileImageUrl: data['profileImageUrl'] ?? '',
  //       country: data['country'] ?? '',
  //       telephone: data['telephone'] ?? '',
  //       joined: data['joined'] as Timestamp,
  //     );
  //   }
  //   return User.empty;
  // }

  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      username: data['username'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      country: data['country'] ?? '',
      telephone: data['telephone'] ?? '',
      joined: data['joined'] as Timestamp,
    );
  }
  
}
