import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restaurant_app/localization/app_translations_delegate.dart';
import 'package:restaurant_app/localization/application.dart';
import 'package:restaurant_app/screens/splash.dart';
import 'package:restaurant_app/util/const.dart';
import 'package:restaurant_app/signupscreen.dart';


import 'basic_example.dart' as basicExample;
import 'namespace_example.dart' as namespaceExample;

/*Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp2());
}*/


/*Future<Null> main() async {
  runApp(new LocalisedApp());
}*/
//void main() => runApp(new MyApp3());


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
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
      home: SplashScreen(),//SplashScreen //HomeFirst//HomeIndex//ScanPage//_StepPageIndicatorDemoState//LocalisedAppState
    );
  }
}

/////Other
class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return new LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpUI(),
      localizationsDelegates: [
        _newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", ""),
        const Locale("es", ""),
      ],
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}

/////Other
class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
            appBar: AppBar(title: Text("Flutter i18n")),
            body: Builder(builder: (BuildContext context) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          basicExample.main();
                        },
                        child: Text("Run `basic` example"),
                      ),
                      RaisedButton(
                        onPressed: () {
                          namespaceExample.main();
                        },
                        child: Text("Run `namespace` example"),
                      ),
                    ],
                  ));
            })));
  }
}

////widgit test
class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

EdgeInsets globalMargin =
const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);
TextStyle textStyle = const TextStyle(
  fontSize: 100.0,
  color: Colors.black,
);

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('SO Help'),
      ),
      body: new Column(
        children: <Widget>[
          new Text(
            number.toString(),
            style: textStyle,
          ),
          new GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              new InkResponse(
                child: new Container(
                    margin: globalMargin,
                    color: Colors.green,
                    child: new Center(
                      child: new Text(
                        "+",
                        style: textStyle,
                      ),
                    )),
                onTap: () {
                  setState(() {
                    number = number + 1;
                  });
                },
              ),
              new Sub(this),
            ],
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: new Icon(Icons.update),
      ),
    );
  }
}

class Sub extends StatelessWidget {

  _MyHomePageState parent;

  Sub(this.parent);

  @override
  Widget build(BuildContext context) {
    return new InkResponse(
      child: new Container(
          margin: globalMargin,
          color: Colors.red,
          child: new Center(
            child: new Text(
              "-",
              style: textStyle,
            ),
          )),
      onTap: () {
        this.parent.setState(() {
          this.parent.number --;
        });
      },
    );
  }
}