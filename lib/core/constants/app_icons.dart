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

class PolicyScreen extends StatefulWidget {
  final String dataForPage;
  final String par1;
  final String apxId;

  PolicyScreen(
      {required this.dataForPage, required this.par1, required this.apxId});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  late AppsflyerSdk _appsflyerSdk;
  String adId = '';
  bool _isFirstLaunch = false;
  String dexsc = '';
  String authxa = '';
  String _afStatus = '';
  Map _deepLinkData = {};
  Map _gcd = {};

  @override
  void initState() {
    super.initState();
    getTracking();
    initAppsflyerSdk();
  }

  Future<void> initAppsflyerSdk() async {
    final AppsFlyerOptions options = AppsFlyerOptions(
      showDebug: false,
      afDevKey: 'XFtWP6JvpRRFdnypp4woCV',
      appId: '6499316167',
      timeToWaitForATTUserAuthorization: 15,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
      manualStart: true,
    );
    _appsflyerSdk = AppsflyerSdk(options);

    await _appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    _appsflyerSdk.onAppOpenAttribution((res) {
      setState(() {
        _deepLinkData = res;
        authxa = res['payload']
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

    _appsflyerSdk.onInstallConversionData((res) {
      setState(() {
        _gcd = res;
        _isFirstLaunch = res['payload']['is_first_launch'];
        _afStatus = res['payload']['af_status'];
        dexsc = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
        print(dexsc);
      });
    });

    _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
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

    _appsflyerSdk.startSDK(
      onSuccess: () {
        print("AppsFlyer SDK initialized successfully.");
      },
    );

    await fetchDatax();
  }

  Future<void> getTracking() async {
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    print(status);
  }

  Future<void> fetchDatax() async {
    try {
      adId = await _appsflyerSdk.getAppsFlyerUID() ?? '';
      adId = '&appsflyer_id=$adId';
      print("AppsFlyer ID: $adId");
    } catch (e) {
      print("Failed to get AppsFlyer ID: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final completeUrl = '${widget.dataForPage}${widget.apxId}${widget.par1}';
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
