
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': '[YOUR iOS AD UNIT ID]',
        'android': '[YOUR ANDROID AD UNIT ID]',
      }
    : {
        'ios': 'ca-app-pub-4716787481822502/4135660246',
        'android': 'ca-app-pub-3940256099942544/6300978111',
      };

class MkBannerADclass{
  

  mkBannerAD(BuildContext context){
  TargetPlatform os = Theme.of(context).platform;
  BannerAd banner = BannerAd(
      // size: AdSize(width: widthsize.toInt(), height: (heightsize*0.05).toInt()),
      size: AdSize.banner,
      // adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {},
      onAdLoaded: (_) {},
    ),
      request: AdRequest(),
  )..load();
  return banner;

  }
}



      