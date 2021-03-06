import 'package:flutter/material.dart';

Widget height(double height) => SizedBox(
      height: height,
    );

Widget width(double width) => SizedBox(
      width: width,
    );

double calHeight(context) => MediaQuery.of(context).size.height;
