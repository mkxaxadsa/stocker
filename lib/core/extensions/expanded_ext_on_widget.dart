import 'package:flutter/material.dart';

extension ExpandedExt on Widget {
  Expanded expanded({int flex = 1}){
    return Expanded(flex: flex,child: this);
  }
}