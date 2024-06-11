import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football/app/global_navigator/global_navigator.dart';
import 'package:football/core/data/news_data.dart';
import 'package:football/core/extensions/align_ext_on_widget.dart';
import 'package:football/core/extensions/expanded_ext_on_widget.dart';
import 'package:football/core/extensions/format_ext_on_datetime.dart';
import 'package:football/core/extensions/mediaquery_ext_on_context.dart';
import 'package:football/core/extensions/padding_extension_on_widget.dart';
import 'package:football/features/main/news/detail_news/detail_news_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            const Text(
              "Breaking news",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ).paddingOnly(bottom: 16),
            SizedBox(
              width: double.maxFinite,
              height: 200,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: breakingNews.length,
                itemBuilder: (context, index) {
                  final item = breakingNews[index];
                  return GestureDetector(
                    onTap: () {
                      GlobalNavigator.push(context, page: DetailNewsScreen(item: item));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CachedNetworkImage(
                              imageUrl: item.imageUrl,
                              cacheKey: item.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 6,
                            right: 6,
                            child: SizedBox(
                              width: context.screenW / 2,
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 6,
                            left: 6,
                            child: SizedBox(
                              width: context.screenW / 2,
                              child: Text(
                                item.creationDate.simpleFormat2,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xffEBEBF5).withOpacity(.6),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ).paddingOnly(bottom: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                breakingNews.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == currentIndex
                        ? const Color(0xff861010)
                        : Colors.white.withOpacity(.3),
                  ),
                ).paddingSymetric(horizontal: 6),
              ),
            ),
            const Text(
              "Last news",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ).paddingOnly(bottom: 25),
            ...List.generate(
              lastNews.length,
              (index) {
                final item = lastNews[index];
                return GestureDetector(
                    onTap: () {
                      GlobalNavigator.push(context, page: DetailNewsScreen(item: item));
                    },
                  child: Container(
                    width: double.maxFinite,
                    height: 100,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: item.imageUrl,
                            cacheKey: item.imageUrl,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ).paddingOnly(right: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              item.creationDate.simpleFormat2,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xffEBEBF5).withOpacity(.6),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ).expanded(),
                      ],
                    ),
                  ),
                ).paddingOnly(bottom: 25);
              },
            ),
          ],
        ).expanded(),
      ],
    );
  }
}
