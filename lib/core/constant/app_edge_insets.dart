import 'package:flutter/material.dart';

class AppEdgeInsets extends EdgeInsets {
  const AppEdgeInsets.all16() : super.all(16);
  const AppEdgeInsets.all12() : super.all(12);

  const AppEdgeInsets.h16() : super.symmetric(horizontal: 16);
  const AppEdgeInsets.h4() : super.symmetric(horizontal: 4);
}
