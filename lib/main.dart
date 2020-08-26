
import 'package:flutter/material.dart';
import 'package:digital/views/login.dart';
import 'package:digital/views/home.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:digital/languesImpl/app_localizations.dart';
import 'package:digital/theme/theme.dart';
import 'languesImpl/language_constants.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme = prefs.getBool("darkTheme") ?? false;
    return runApp(
      ChangeNotifierProvider<ThemeProvider>(
        child: MyApp(),
        create: (BuildContext context) {
          return ThemeProvider(isDarkTheme);
        },
      ),
    );
  });
}




/*void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await loadPrefs();


  //pour tester api graph machine
 /* var res = await Network().getData('/machines/3/stats');
  List date = [];
  List xa = [];
  List ya = [];
  List za = [];
  for(int i = 0; i< res.length ; i++){
    date.add(res[i]['created_at']);
    xa.add(res[i]['xa']);
    ya.add(res[i]['ya']);
    za.add(res[i]['za']);
  }
  print(date);
  print(xa);
  print(ya);
  print(za);

  */

  runApp(MyApp());
*/





class MyApp extends StatefulWidget {


  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state =
    context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }




  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }



  @override
  void didChangeDependencies() {
    this._fetchLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          theme: value.getTheme(),
          /* theme : Provider.of<ThemeState>(context).theme == ThemeType.DARK
          ? ThemeData.dark()
          : ThemeData.light(),*/
          debugShowCheckedModeBanner: false,
          title: 'Flutter Localization',
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ar', 'AR'),
            Locale('fr', 'FR'),
          ],
          locale: _locale,
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          home: CheckAuth(),
        );
      },
    );
  }
  _fetchLocale() async {
    Locale tempLocale;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = (prefs.getString(LAGUAGE_CODE) ?? 'en');
    switch (languageCode) {
      case ENGLISH:
        tempLocale = Locale(ENGLISH, 'US');
        break;
      case ARABIC:
        tempLocale = Locale(ARABIC, 'AR');
        break;
      case FRENCH:
        tempLocale = Locale(FRENCH, 'FR');
        break;
      default:
        tempLocale = Locale(ENGLISH, 'US');
    }
    return tempLocale;
  }
}



class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    print("token="+token);
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = MyHomePage();
    } else {
      child = Login();
    }
    return Scaffold(
      body: child,
    );
  }
}