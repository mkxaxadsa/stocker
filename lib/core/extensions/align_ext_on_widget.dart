import 'package:flutter/material.dart';

extension AlignExt on Widget{
  Align align([Alignment alignment = Alignment.center]){
    return Align(
      alignment: alignment,
      child: this,
    );
  }
}