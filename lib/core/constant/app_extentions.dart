import 'package:flutter/material.dart';

extension Spacing on num {
  /// Horizontal spacing: `10.widthBox`
  SizedBox get widthBox => SizedBox(width: toDouble());

  /// Vertical spacing: `16.heightBox`
  SizedBox get heightBox => SizedBox(height: toDouble());
}
