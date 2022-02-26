import 'package:bluebaker/features/bluebaker/presentation/pages/bluebaker/bluebaker_category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PageViewBlueBakerItem extends StatelessWidget {
  const PageViewBlueBakerItem({
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
          BlueBakerCategory.routeName,
          arguments: BlueBakerCategoryArgs(
            id: id,
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
