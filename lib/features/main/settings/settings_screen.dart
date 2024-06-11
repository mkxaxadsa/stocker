import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:football/core/extensions/align_ext_on_widget.dart';
import 'package:football/core/extensions/expanded_ext_on_widget.dart';
import 'package:football/core/extensions/padding_extension_on_widget.dart';
import 'package:in_app_review/in_app_review.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: 44,
          child: const Text(
            "Settings",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ).align(),
        ).paddingOnly(bottom: 24),
        Container(
          width: double.maxFinite,
          height: 112,
          decoration: BoxDecoration(
            color: const Color(0xff1C1C1E),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsView(
                            url: 'https://forms.gle/D1CdvyAzKiCj3RMy7'),
                      ),
                    );
                  },
                  child: _item("Write Support")),
              _divider(),
              InkWell(
                onTap: () {
                  InAppReview.instance
                      .openStoreListing(appStoreId: '6504202820');
                },
                child: _item("Rate the app"),
              ),
            ],
          ),
        ).paddingOnly(bottom: 24),
        Container(
          width: double.maxFinite,
          height: 112,
          decoration: BoxDecoration(
            color: const Color(0xff1C1C1E),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsView(
                            url:
                                'https://docs.google.com/document/d/1nTVtup6vx0Fwem4nXrXxyxytlwHLSsWT10lBd6SDrCA/edit?usp=sharing'),
                      ),
                    );
                  },
                  child: _item("Privacy Policy")),
              _divider(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsView(
                          url:
                              'https://docs.google.com/document/d/1yLaTAeayr8L1x-D5iJ9ZJ8tAMHAWzOLAwVJgjiZsjSY/edit?usp=sharing'),
                    ),
                  );
                },
                child: _item("Terms & Conditions"),
              ),
            ],
          ),
        ).paddingOnly(bottom: 24),
      ],
    ).paddingSymetric(horizontal: 16);
  }

  Widget _divider() {
    return Container(
      width: double.maxFinite,
      height: .5,
      color: const Color(0xffEBEBF5),
    ).paddingOnly(left: 16);
  }

  Widget _item(String text) {
    return SizedBox(
      width: double.maxFinite,
      height: 55,
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ).expanded(),
          Icon(
            Icons.chevron_right,
            color: const Color(0xffEBEBF5).withOpacity(.6),
            size: 30,
          ),
        ],
      ).paddingSymetric(horizontal: 16),
    );
  }
}

class SettingsView extends StatelessWidget {
  final String url;

  const SettingsView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
      ),
    );
  }
}
