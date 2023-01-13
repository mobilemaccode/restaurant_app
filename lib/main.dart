import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/BookYourTable/book_your_table_model.dart';
import 'package:restaurant_app/BookingSummary/booking_summary_model.dart';
import 'package:restaurant_app/SelectPaymentMethod/select_payement_method_model.dart';
import 'package:restaurant_app/screens/MyHomePage.dart';
import 'package:restaurant_app/screens/home_index.dart';
import 'package:restaurant_app/screens/scan.dart';
import 'package:restaurant_app/screens/splash.dart';
import 'package:restaurant_app/util/const.dart';
import 'package:restaurant_app/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => BookYourTableModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => BookingSummaryModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => SelectPaymentMethodModel(),
          ),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      home: SplashScreen(), //SplashScreen //HomeFirst//HomeIndex//ScanPage
    );
  }
}
