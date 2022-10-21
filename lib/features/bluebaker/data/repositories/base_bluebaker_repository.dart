import 'package:bluebaker/exports.dart';

abstract class BaseBlueBakerRepository {
  // General BlueBaker Items & Collections
  Future<List<Item>> fetchItems({required String userId});
  Future<List<Collection>> fetchCollections({required String userId});
  Future<List<BlueBaker>> fetchBlueBaker({required String userId});
  Future<List<Item>> searchBlueBaker({required String query});

  // Favorite Items
  Future<List<Item>> fetchWishlistItems({required String userId});
  Future<List<Item>> fetchWishlist({required String userId});

  void addItemToWishlist({
    required String userId,
    required String addItemID,
  });

  void removeItemFromWishlist({
    required String userId,
    required String removeItemID,
  });

  Future<bool> isFavoriteItem({
    required String userId,
    required String userWishedItemID,
  });
}
