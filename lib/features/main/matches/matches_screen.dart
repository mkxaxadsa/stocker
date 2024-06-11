import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/core/constants/app_images.dart';
import 'package:football/core/extensions/align_ext_on_widget.dart';
import 'package:football/core/extensions/expanded_ext_on_widget.dart';
import 'package:football/core/extensions/format_ext_on_datetime.dart';
import 'package:football/core/extensions/padding_extension_on_widget.dart';
import 'package:football/data/apis/matches_api.dart';
import 'package:football/data/models/match.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List<FootballMatch> data = [];

  Future<void> init() async {
    try {
      data = await MatchesApi().fetchMatches(DateTime.now());
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: 44,
          child: const Text(
            "Matches",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ).align(),
        ).paddingOnly(bottom: 24),
        if (data.isEmpty)
          const CupertinoActivityIndicator(
            color: Colors.red,
          ).align().expanded()
        else
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final match = data[index];
              return SizedBox(
                width: double.maxFinite,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: const Color(0xff1C1C1E),
                        ),
                      ),
                      Positioned.fill(
                        child: Image.asset(
                          AppImages.ticTacToeBg,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Column(
                          children: [
                            Text(
                              match.league,
                              style: const TextStyle(color: Colors.white),
                            ).paddingOnly(top: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _teamInfo(
                                    logo: match.homeTeamLogo,
                                    name: match.homeTeamTitle),
                                SizedBox(
                                  height: double.maxFinite,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "VS",
                                        style: TextStyle(color: Colors.white),
                                      ).paddingSymetric(horizontal: 16),
                                      Text(
                                        "(${match.homeGoals}-${match.awayGoals})",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 182, 180, 180),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ).paddingOnly(top: 8),
                                    ],
                                  ),
                                ),
                                _teamInfo(
                                    logo: match.awayTeamLogo,
                                    name: match.awayTeamTitle),
                              ],
                            ).expanded(),
                          ],
                        ).paddingSymetric(horizontal: 16),
                      ),
                    ],
                  ),
                ),
              ).paddingOnly(bottom: 16);
            },
          ).expanded(),
      ],
    );
  }

  Widget _teamInfo({
    required String logo,
    required String name,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            imageUrl: logo,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ).paddingOnly(bottom: 10),
        Text(
          name,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    ).paddingOnly(top: 16).expanded();
  }
}
