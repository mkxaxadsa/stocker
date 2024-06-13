import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AppIcons {
  static const _prefix = "assets/icons/";
  static const news = "${_prefix}news.png";
  static const puzzle = "${_prefix}puzzle.png";
  static const matches = "${_prefix}matches.png";
  static const settings = "${_prefix}settings.png";
  static const ticTacToe = "${_prefix}tic_tac_toe.png";
  static const x = "${_prefix}x.png";
  static const o = "${_prefix}o.png";
  static const chevronLeft = "${_prefix}chevron_left.png";
  static const eye = "${_prefix}eye.png";
}

class TermsAndConditions extends StatefulWidget {
  final String termsxa;
  final String maxsad;
  final String fdsmkfds;

  TermsAndConditions(
      {required this.termsxa, required this.maxsad, required this.fdsmkfds});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  late AppsflyerSdk fsdsfdsf;
  String dsaxsafsdfds = '';
  bool fdsfdsfdg = false;
  String dsqsdasdfaf = '';
  String dasmkodmasd = '';
  String jmkdasnkdjas = '';
  Map _deepLinkData = {};
  Map _gcd = {};

  @override
  void initState() {
    super.initState();
    mfijosdmfdsof();
    fnujdisfjksdfdskf();
  }

  Future<void> fnujdisfjksdfdskf() async {
    final AppsFlyerOptions options = AppsFlyerOptions(
      showDebug: false,
      afDevKey: 'EjB2oxnrzjoLfcdgoJtWFh',
      appId: '6504202820',
      timeToWaitForATTUserAuthorization: 15,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
      manualStart: true,
    );
    fsdsfdsf = AppsflyerSdk(options);

    await fsdsfdsf.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    fsdsfdsf.onAppOpenAttribution((res) {
      setState(() {
        _deepLinkData = res;
        dasmkodmasd = res['payload']
            .entries
            .where((e) => ![
                  'install_time',
                  'click_time',
                  'af_status',
                  'is_first_launch'
                ].contains(e.key))
            .map((e) => '&${e.key}=${e.value}')
            .join();
      });
    });

    fsdsfdsf.onInstallConversionData((res) {
      setState(() {
        _gcd = res;
        fdsfdsfdg = res['payload']['is_first_launch'];
        jmkdasnkdjas = res['payload']['af_status'];
        dsqsdasdfaf = '&is_first_launch=$fdsfdsfdg&af_status=$jmkdasnkdjas';
        print(dsqsdasdfaf);
      });
    });

    fsdsfdsf.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print(dp.deepLink?.toString());
          print("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          print("deep link not found");
          break;
        case Status.ERROR:
          print("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("deep link status parsing error");
          break;
      }
      print("onDeepLinking res: " + dp.toString());
      setState(() {
        _deepLinkData = dp.toJson();
      });
    });

    fsdsfdsf.startSDK(
      onSuccess: () {
        print("AppsFlyer SDK initialized successfully.");
      },
    );

    await fetchDatax();
  }

  Future<void> mfijosdmfdsof() async {
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    print(status);
  }

  Future<void> fetchDatax() async {
    try {
      dsaxsafsdfds = await fsdsfdsf.getAppsFlyerUID() ?? '';
      dsaxsafsdfds = '&appsflyer_id=$dsaxsafsdfds';
      print("AppsFlyer ID: $dsaxsafsdfds");
    } catch (e) {
      print("Failed to get AppsFlyer ID: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final completeUrl = '${widget.termsxa}${widget.fdsmkfds}${widget.maxsad}';
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(completeUrl),
          ),
        ),
      ),
    );
  }
}
