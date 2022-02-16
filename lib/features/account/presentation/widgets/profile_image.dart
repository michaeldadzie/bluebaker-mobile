import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  final double radius;
  final String profileImageUrl;
  final Color? backgroundColor;
  final File? profileImage;
  const UserProfileImage({
    Key? key,
    required this.radius,
    required this.profileImageUrl,
    this.profileImage,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade300,
      backgroundImage: profileImage != null
          ? FileImage(profileImage!)
          : profileImageUrl.isNotEmpty
              ? CachedNetworkImageProvider(profileImageUrl) as ImageProvider
              : null,
      child: _noprofile(),
    );
  }

  Icon _noprofile() {
    if (profileImage == null && profileImageUrl.isEmpty) {
      return Icon(
        FeatherIcons.user,
        color: Colors.white,
        size: radius * 1.5,
      );
    }
    return const Icon(null);
  }
}
