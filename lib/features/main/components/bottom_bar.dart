// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/core/constants/app_icons.dart';
import 'package:football/core/extensions/expanded_ext_on_widget.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.currentPage,
    required this.onPageChanged,
  });
  final int currentPage;
  final void Function(int) onPageChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 62,
      color: Colors.transparent,
      child: Row(
        children: [
          _item(icon: CupertinoIcons.doc_plaintext, index: 0),
          _item(icon: CupertinoIcons.gamecontroller, index: 1),
          _item(icon: CupertinoIcons.app, index: 2),
          _item(icon: CupertinoIcons.sportscourt, index: 3),
          _item(icon: CupertinoIcons.settings, index: 4),
        ],
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        onPageChanged(index);
      },
      child: Container(
        height: double.maxFinite,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 34,
          color: index == currentPage
              ? const Color.fromARGB(255, 184, 22, 22)
              : const Color.fromARGB(255, 95, 95, 96),
        ),
      ),
    ).expanded();
  }
}
