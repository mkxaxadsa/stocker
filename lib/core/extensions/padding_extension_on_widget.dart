import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Padding paddingLTRB(double l, double t, double r, double b) {
    return Padding(
      padding: EdgeInsets.fromLTRB(l, t, r, b),
      child: this,
    );
  }

  Padding paddingSymetric({double vertical = 0.0, double horizontal = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical,
        horizontal: horizontal,
      ),
      child: this,
    );
  }

  Padding paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Padding paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }
}
