import 'package:digital/languesImpl/app_localizations.dart';
import 'package:digital/languesImpl/language_constants.dart';
import 'package:flutter/material.dart';

import 'package:digital/main.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';

import 'package:digital/theme/theme.dart';


class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() =>  _SettingsState();
}

class _SettingsState extends State<Settings> {
  void _changeLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LAGUAGE_CODE, languageCode);
    Locale locale;
    switch (languageCode) {
      case ENGLISH:
        locale = Locale(languageCode, 'US');
        break;
      case ARABIC:
        locale = Locale(languageCode, 'AR');
        break;
      case FRENCH:
        locale = Locale(languageCode, 'FR');
    }
    MyApp.setLocale(context, locale);
  }

  double scaleFactor = 1;
  ThemeData theme;
  bool darkTheme;
  Map<String, dynamic> update;
  bool isUpdateAvailable = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    darkTheme = theme.brightness == Brightness.dark ? true : false;
    // AppLocalizations lang = AppLocalizations.of(context);


    if (MediaQuery
        .of(context)
        .size
        .width < 400) {
      scaleFactor = 0.75;
    } else if (MediaQuery
        .of(context)
        .size
        .width <= 450) {
      scaleFactor = 0.9;
    }
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SizedBox(height: 16 * scaleFactor,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  buildTranslate(context, 'Settings'),
                  style: TextStyle(
                    fontSize: 25 * scaleFactor,

                  ),
                ),
              ),
              Divider(),
              Container(
                height: 56 * scaleFactor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 20 * scaleFactor,),
                    Icon(
                      darkTheme ? Icons.brightness_2 : Icons.brightness_5,
                      size: 24 * scaleFactor,
                      color: theme.accentColor,
                    ),
                    SizedBox(width: 20 * scaleFactor,),
                    Expanded(
                      child: Text(
                        buildTranslate(context, 'Display mode'),
                        style: TextStyle(

                          fontSize: 16 * scaleFactor,
                        ),
                      ),
                    ),

                    IconButton(
                      icon: Icon(Icons.brightness_medium,color: Colors.amber,),
                      color: Colors.white,
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false).swapTheme();
                      },
                    ),

                    SizedBox(width: 20,),
                  ],
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  showDialog<Map<String, String>>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: Text(
                            buildTranslate(context, 'Choose language'),
                            style: TextStyle(

                              fontSize: 16 * scaleFactor,
                            ),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "   English""🇺🇸",
                                style: TextStyle(

                                    fontSize: 18 * scaleFactor
                                ),
                              ),
                              trailing: Container(
                                height: 20 * scaleFactor,
                                width: 20 * scaleFactor,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(
                                    width: 2,
                                    color: theme.accentColor,
                                  ),
                                  // color: lang.locale.languageCode == "en"?theme.accentColor:Colors.transparent,
                                ),
                              ),
                              onTap: () {

                                _changeLanguage(ENGLISH);
                                Navigator.of(context).pop();

                              },
                            ),
                            ListTile(
                              title: Text(
                                "   Francais""🇫🇷",
                                style: TextStyle(

                                    fontSize: 18 * scaleFactor
                                ),
                              ),
                              trailing: Container(
                                height: 20 * scaleFactor,
                                width: 20 * scaleFactor,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(
                                    width: 2,
                                    color: theme.accentColor,
                                  ),
                                  // color: lang.locale.languageCode == "hi"?theme.accentColor:Colors.transparent,
                                ),
                              ),
                              onTap: () {
                                _changeLanguage(FRENCH);
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: Text(
                                "   العربية""🇲🇦",
                                style: TextStyle(

                                    fontSize: 18 * scaleFactor
                                ),
                              ),
                              trailing: Container(
                                height: 20 * scaleFactor,
                                width: 20 * scaleFactor,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(
                                    width: 2,
                                    color: theme.accentColor,
                                  ),
                                  // color: lang.locale.languageCode == "en"?theme.accentColor:Colors.transparent,
                                ),
                              ),
                              onTap: () {

                                _changeLanguage(ARABIC);
                                Navigator.of(context).pop();

                              },
                            ),
                          ],
                        );
                      }
                  ).then((Map<String, String> returnVal) {
                    if (returnVal != null) {
                      // widget.onLocaleChange(Locale(returnVal["lang_code"],returnVal["country_code"]));
                      setState(() {
                        //UpdateLog.refresh(returnVal["lang_code"]);
                      });
                    }
                  });
                },
                child: Container(
                  height: 56 * scaleFactor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 20 * scaleFactor,),
                      Icon(
                        MaterialCommunityIcons.translate,
                        size: 24 * scaleFactor,
                        color: theme.accentColor,
                      ),
                      SizedBox(width: 20 * scaleFactor,),
                      Expanded(
                        child: Text(
                          buildTranslate(context, 'Language'),

                          style: TextStyle(

                            fontSize: 16 * scaleFactor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              Divider(),
            ],
          ),
        ),
      ),
    );
  }


}



















/*  Container(
          child: Column(
            children: <Widget>[
              Text(buildTranslate(context, 'about_app')),

            FlatButton(
               // height: 50,
                color: Colors.red,
               /* shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),*/
                onPressed: () {
                  _changeLanguage(ENGLISH);
                },
                child: Text(
                  buildTranslate(context, 'english'),
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),

              MaterialButton(
                height: 50,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  _changeLanguage(FARSI);
                },
                child: Text(
                  buildTranslate(context, 'farsi'),
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              MaterialButton(
                height: 50,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  _changeLanguage(FRENCH);
                },
                child: Text(
                  buildTranslate(context, 'french'),
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ],
          ),


    );
  }
}*/
