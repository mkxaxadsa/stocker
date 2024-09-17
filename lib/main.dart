import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_asa_attribution/flutter_asa_attribution.dart';
import 'package:football/app/app.dart';
import 'package:football/features/main/puzzle/detail_puzzle/nn.dart';
import 'package:football/features/splash/firebase_options.dart';
import 'package:football/helpers/hive_helper.dart';

late AppsflyerSdk gdfgfdgfddf;
bool stat = false;
String gdfcdscs = '';
String asdsafdaf = '';
Map _deepLinkData = {};
Map _gcd = {};
bool hjgjhgjghhngvdf = false;
String dsaxaxsa = '';
String fdsfdsxsds = '';
String keyxId = '';
String keyxXd = '';
String fdsxsdfdsfds = '';
String safdfdsfds = '';

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
  await hfghjgfjfg().activate();
  await fsdfdsfsgfd();
  await fdsfsd();
  String? token = await FlutterAsaAttribution.instance.attributionToken();
  await fetchAttributionDetails();
  runApp(const FootballApp());
}

Future<void> fsdfdsfsgfd() async {
  final AppsFlyerOptions options = AppsFlyerOptions(
    showDebug: false,
    afDevKey: 'EjB2oxnrzjoLfcdgoJtWFh',
    appId: '6504202820',
    timeToWaitForATTUserAuthorization: 15,
    disableAdvertisingIdentifier: false,
    disableCollectASA: false,
    manualStart: true,
  );
  gdfgfdgfddf = AppsflyerSdk(options);

  await gdfgfdgfddf.initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: true,
    registerOnDeepLinkingCallback: true,
  );

  gdfgfdgfddf.onAppOpenAttribution((res) {
    _deepLinkData = res;
    asdsafdaf = res['payload']
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

  gdfgfdgfddf.onInstallConversionData((res) {
    _gcd = res;
    hjgjhgjghhngvdf = res['payload']['is_first_launch'];
    dsaxaxsa = res['payload']['af_status'];
    gdfcdscs = '&is_first_launch=$hjgjhgjghhngvdf&af_status=$dsaxaxsa';
  });

  gdfgfdgfddf.onDeepLinking((DeepLinkResult dp) {
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

  gdfgfdgfddf.startSDK(
    onSuccess: () {
      print("AppsFlyer SDK initialized successfully.");
    },
  );

  await fetchDatax();
}

Future<void> fetchAttributionDetails() async {
  try {
    if (gdfgfdgfddf != null) {
      Map<String, dynamic>? data =
          await FlutterAsaAttribution.instance.requestAttributionDetails();
      keyxId = data?["campaignId"]?.toString() ?? "";
      keyxXd = data?["keywordId"]?.toString() ?? "";
      print('good');
    } else {
      print('AppsFlyer SDK is not initialized yet.');
    }
  } on PlatformException catch (e) {
    print('Failed to get attribution details: $e');
  }
}

Future<void> fdsfsd() async {
  final TrackingStatus dasfa =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(dasfa);
}
