import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../bluebaker/presentation/pages/collections/collection_category.dart';

class PageViewCollectionsItem extends StatelessWidget {
  const PageViewCollectionsItem({
    Key? key,
    required this.title,
    required this.photoUrl,
    required this.id,
  }) : super(key: key);

  final String title, photoUrl, id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          CollectionCategory.routeName,
          arguments: CollectionCategoryArgs(
            id: id,
            title: title,
            photoUrl: photoUrl,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: FadeInImage(
                placeholder: const AssetImage('assets/load/load.gif'),
                image: CachedNetworkImageProvider(photoUrl),
                fadeInDuration: const Duration(milliseconds: 300),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
