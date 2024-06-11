import 'package:flutter/material.dart';

extension HideKeyboard on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
