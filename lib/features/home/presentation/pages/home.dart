import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'settings.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              Settings.routeName,
            ),
            icon: Icon(
              FeatherIcons.settings,
              color: Theme.of(context).focusColor,
            ),
          )
        ],
      ),
    );
  }
}
