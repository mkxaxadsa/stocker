import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:football/app/app.dart';
import 'package:football/features/main/puzzle/detail_puzzle/nn.dart';
import 'package:football/features/splash/firebase_options.dart';
import 'package:football/helpers/hive_helper.dart';

late AppsflyerSdk _appsflyerSdk;
bool stat = false;
String dexsc = '';
String authxa = '';
Map _deepLinkData = {};
Map _gcd = {};
bool _isFirstLaunch = false;
String _afStatus = '';
String _campaign = '';
String adId = '';
String _campaignId = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await NOtifications().activate();
  await initAppsflyerSdk();
  await getTracking();
  runApp(const FootballApp());
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

  _appsflyerSdk.onInstallConversionData((res) {
    _gcd = res;
    _isFirstLaunch = res['payload']['is_first_launch'];
    _afStatus = res['payload']['af_status'];
    dexsc = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
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
    _deepLinkData = dp.toJson();
  });

  _appsflyerSdk.startSDK(
    onSuccess: () {
      print("AppsFlyer SDK initialized successfully.");
    },
  );
  await fetchDatax();
}

Future<void> getTracking() async {
  final TrackingStatus dasfa =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(dasfa);
}
