import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAds {
  Future<InitializationStatus> initialization;

  GoogleAds({required this.initialization});

  String get bannerAdsId {
    return 'ca-app-pub-3940256099942544/6300978111';
  }

  BannerAdListener get bannerAd => _bannerAdListener;

  final BannerAdListener _bannerAdListener = BannerAdListener(
    onAdLoaded: (Ad ad) => print("Ad Loaded"),
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print("ad error");
    },
    onAdOpened: (Ad ad) => print("open ad"),
    onAdClosed: (Ad ad) => print("close ad"),
  );
}
