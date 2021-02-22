import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IntroIndexIndicator extends StatelessWidget {
  IntroIndexIndicator({
    Key key,
    this.isActive,
  }) : super(key: key);
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isActive ? Color(0xFF256BEE) : Color(0XFFDADAE5),
        ),
        width: isActive ? 30 : 10,
        height: 10,
      ),
    );
  }
}
