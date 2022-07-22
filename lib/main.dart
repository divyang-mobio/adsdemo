import 'package:adsdemo/utils/google_ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initializes = MobileAds.instance.initialize();
  runApp(MyApp(initialization: initializes));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.initialization}) : super(key: key);
  final Future<InitializationStatus> initialization;

  @override
  Widget build(BuildContext context) {
    return Provider<GoogleAds>(
      create: (context) => GoogleAds(initialization: initialization),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Ads Demo'),
      ),
    );
  }
}
