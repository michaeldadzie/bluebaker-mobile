import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 17,
            bottom: 17,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          side: BorderSide(
            width: 2,
            color: Theme.of(context).primaryColor,
          ),
        ),
        onPressed: () {},
        child: Center(
          child: SizedBox(
            width: 20.5,
            height: 20.5,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
      ),
    );
  }
}
