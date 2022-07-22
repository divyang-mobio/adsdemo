import '../utils/google_ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../models/list_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Object> _counter =
      List.generate(50, (index) => DataModel(name: "India", code: "000"));

  BannerAd? _bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bannerAd = bannerAd();
    insertAdInList();
  }

  insertAdInList() {
    for (var i = _counter.length - 5; i >= 1; i -= 10) {
      _counter.insert(i, bannerAd());
    }
  }

  BannerAd bannerAd() {
    return BannerAd(
        adUnitId: Provider.of<GoogleAds>(context).bannerAdsId,
        listener: Provider.of<GoogleAds>(context).bannerAd,
        request: const AdRequest(),
        size: AdSize.banner)
      ..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _counter.length,
            itemBuilder: (_, index) {
              Object? item = _counter[index];
              if (item is DataModel) {
                return Card(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                        ),
                        const SizedBox(height: 10),
                        Text(item.code)
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: 50,
                  child: AdWidget(ad: item as BannerAd),
                );
              }
            },
          ),
          if (_bannerAd != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            )
        ],
      ),
    );
  }
}
