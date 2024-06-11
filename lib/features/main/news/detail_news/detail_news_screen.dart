// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:football/core/constants/app_icons.dart';
import 'package:football/core/extensions/align_ext_on_widget.dart';
import 'package:football/core/extensions/expanded_ext_on_widget.dart';
import 'package:football/core/extensions/padding_extension_on_widget.dart';
import 'package:football/core/models/news_item_model.dart';

class DetailNewsScreen extends StatefulWidget {
  const DetailNewsScreen({
    super.key,
    required this.item,
  });
  final NewsItemModel item;
  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 44,
                child: const Text(
                  "News",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ).align(),
              ),
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      AppIcons.chevronLeft,
                      height: 22,
                    ),
                  ).paddingOnly(bottom: 25).align(Alignment.centerLeft),
                  Text(
                    widget.item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ).paddingOnly(bottom: 28),
                  const Text(
                    '1 min read',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0x99EBEBF5),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ).paddingOnly(bottom: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: widget.item.imageUrl,
                      cacheKey: widget.item.imageUrl,
                      height: 200,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ).paddingOnly(bottom: 34),
                  Text(
                    widget.item.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  )
                ],
              ).expanded(),
            ],
          ),
        ),
      ),
    );
  }
}
