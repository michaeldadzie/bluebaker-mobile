import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String itemID;
  final String name;
  final String description;
  final String price;
  final String photoUrl;
  final List<String> collectionID;
  final List<String> bluebakerID;

  const Item({
    required this.id,
    required this.itemID,
    required this.name,
    required this.description,
    required this.price,
    required this.photoUrl,
    required this.collectionID,
    required this.bluebakerID,
  });

  //static const empty = Item()
  static const empty = Item(
    id: '',
    itemID: '',
    name: '',
    description: '',
    price: '',
    photoUrl: '',
    collectionID: [],
    bluebakerID: [],
  );

  @override
  List<Object?> get props => [
        id,
        itemID,
        name,
        description,
        price,
        photoUrl,
        collectionID,
        bluebakerID,
      ];

  Item copyWith({
    String? id,
    String? itemID,
    String? name,
    String? description,
    String? price,
    String? photoUrl,
    List<String>? collectionID,
    List<String>? bluebakerID,
  }) {
    return Item(
      id: id ?? this.id,
      itemID: itemID ?? this.itemID,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      photoUrl: photoUrl ?? this.photoUrl,
      collectionID: collectionID ?? this.collectionID,
      bluebakerID: bluebakerID ?? this.bluebakerID,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'itemID': itemID,
      'name': name,
      'description': description,
      'price': price,
      'photoUrl': photoUrl,
      'collectionID': collectionID,
      'bluebakerID': bluebakerID,
    };
  }

  factory Item.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Item(
      id: doc.id,
      itemID: data['itemID'],
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      collectionID: List<String>.from(data['collectionID']),
      bluebakerID: List<String>.from(data['bluebakerID']),
    );
  }
}
