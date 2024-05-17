
import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class TestConfig {
  static final _config = FirebaseRemoteConfig.instance;

  static const _defaultValues = {
    "forceupdate": "true"
  };

  static Future<void> initConfig() async {
    await _config.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 30)));

    // await _config.setDefaults(_defaultValues);
    await _config.fetchAndActivate();
    log('Remote Config Data: ${_config.getBool('forceupdate')}');
    print('Remote Config Data: ${_config.getBool('forceupdate')}');

    _config.onConfigUpdated.listen((event) async {
      await _config.activate();
      log('Updated: ${_config.getBool('forceupdate')}');
    });
  }

  static bool get _showAd => _config.getBool('forceupdate');

  //ad ids
  static String get nativeAd => _config.getString('native_ad');
  static String get interstitialAd => _config.getString('interstitial_ad');
  static String get rewardedAd => _config.getString('rewarded_ad');

  static bool get hideAds => !_showAd;
}
