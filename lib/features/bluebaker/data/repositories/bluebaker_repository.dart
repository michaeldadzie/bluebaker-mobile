import 'dart:developer';

import 'package:bluebaker/core/config/paths.dart';
import 'package:bluebaker/features/bluebaker/data/models/bluebaker_model.dart';
import 'package:bluebaker/features/bluebaker/data/models/item_model.dart';
import 'package:bluebaker/features/explore/data/models/collection_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'base_bluebaker_repository.dart';

class BlueBakerRepository extends BaseBlueBakerRepository {
  final FirebaseFirestore _firebaseFirestore;

  BlueBakerRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Item>> fetchItems({required String userId}) async {
    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection(Paths.items)
        .orderBy('name', descending: false)
        .get();
    return querySnapshot.docs.map((doc) => Item.fromDocument(doc)).toList();
  }

  @override
  Future<List<Collection>> fetchCollections({required String userId}) async {
    QuerySnapshot querySnapshot =
        await _firebaseFirestore.collection(Paths.collections).get();
    return querySnapshot.docs
        .map((doc) => Collection.fromDocument(doc))
        .toList();
  }

  @override
  Future<List<BlueBaker>> fetchBlueBaker({required String userId}) async {
    QuerySnapshot querySnapshot =
        await _firebaseFirestore.collection(Paths.bluebaker).get();
    return querySnapshot.docs
        .map((doc) => BlueBaker.fromDocument(doc))
        .toList();
  }

  @override
  Future<List<Item>> searchBlueBaker({required String query}) async {
    final itemsnap = await _firebaseFirestore
        .collection(Paths.items)
        .where(
          'name',
          isGreaterThanOrEqualTo: query.toUpperCase().trim(),
        )
        .orderBy('name', descending: false)
        .get();
    return itemsnap.docs.map((doc) => Item.fromDocument(doc)).toList();
  }

  @override
  Future<List<Item>> fetchWishlistItems({required String userId}) async {
    final querySnapshot = _firebaseFirestore
        .collection(Paths.favoriteItems)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _firebaseFirestore
            .doc(userId)
            .collection(Paths.userFavoriteItems)
            .get();
      });
      return querySnapshot.docs.map((doc) => Item.fromDocument(doc)).toList();
    });
    return querySnapshot;
  }

  @override
  Future<List<Item>> fetchWishlist({required String userId}) async {
    QuerySnapshot<Map<String, dynamic>> listSnapshot = await _firebaseFirestore
        .collection(Paths.favoriteItems)
        .doc(userId)
        .collection(Paths.userFavoriteItems)
        .get();
    final allFavorites = listSnapshot.docs.map((doc) => doc.id).toList();
    log('All Favorite Items' + allFavorites.toString());

    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection(Paths.items)
        .orderBy('name', descending: false)
        .where('itemID', whereIn: allFavorites)
        .get();
    return querySnapshot.docs.map((doc) => Item.fromDocument(doc)).toList();
  }

  @override
  void addItemToWishlist({required String userId, required String addItemID}) {
    _firebaseFirestore
        .collection(Paths.favoriteItems)
        .doc(userId)
        .collection(Paths.userFavoriteItems)
        .doc(addItemID)
        .set({});
  }

  @override
  void removeItemFromWishlist(
      {required String userId, required String removeItemID}) {
    _firebaseFirestore
        .collection(Paths.favoriteItems)
        .doc(userId)
        .collection(Paths.userFavoriteItems)
        .doc(removeItemID)
        .delete();
  }

  @override
  Future<bool> isFavoriteItem(
      {required String userId, required String userWishedItemID}) async {
    final userFavoriteDoc = await _firebaseFirestore
        .collection(Paths.favoriteItems)
        .doc(userId)
        .collection(Paths.userFavoriteItems)
        .doc(userWishedItemID)
        .get();
    return userFavoriteDoc.exists;
  }
}
