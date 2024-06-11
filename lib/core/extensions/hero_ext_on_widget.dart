import 'package:flutter/material.dart';

extension HeroExt on Widget {
  Widget makeHero({String? tag}){
    if(tag != null){
      return Hero(tag: tag, child: this);
    }
    return this;
  }
}