import 'package:flutter/material.dart';

extension OpacityExt on Widget {
  Opacity opacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }
}
