import 'package:digital/languesImpl/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:digital/views/login.dart';
import 'package:digital/views/dashboard.dart';
import 'package:digital/views/categories.dart';
import 'package:digital/views/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './bottom_navy_bar.dart';
import 'package:digital/main.dart';

import 'package:flutter/material.dart';


import 'package:shared_preferences/shared_preferences.dart';
import './bottom_navy_bar.dart';
import 'about.dart';

/*class Home extends StatefulWidget {
  Home({Key key}) :super(key:key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  void _showSuccessDialog(){
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  void _changeLanguage(Language language ) async{
    Locale _temp = await setLocale(language.languageCode);
    MyApp.setLocale(context,_temp);

  }

  @override
  void initState(){

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage('ggg'),
      // routes: <String, WidgetBuilder>{
      //   '/home': (BuildContext context) => MyHomePage(title: 'Digital Mobil App'),
      // },//MyHomePage(title: 'Digital Mobil App'),
    );
  }



}

   */
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
 // final String title = 'Digital Mobile Application';

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
/*  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  void _showSuccessDialog(){
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  void _changeLanguage(Language language ) async{
    Locale _temp = await setLocale(language.languageCode);
    MyApp.setLocale(context,_temp);

  }

  @override
  void initState(){

    super.initState();
  }*/
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  void _onItemTapped(int index) {
    setState(() {
      if(index == 4){
        logout();
      }
      _selectedIndex = index;
    });
  }
  List<Widget> _body = <Widget>[
    Dashboard(),
    Categories(),
    Shell(),
    Settings()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buildTranslate(context, 'Digital Mobile Application')),
      ),
      body: SafeArea(
        child: _body[_selectedIndex],
      ),

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text(buildTranslate(context, 'Home')),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.business),
            title: Text(buildTranslate(context, 'Categories')),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.insert_chart ),
            title: Text(buildTranslate(context, 'Statistics')),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text(buildTranslate(context, 'Settings')),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.exit_to_app),
            title: Text(buildTranslate(context, 'Logout')),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,

          ),
        ],
        onItemSelected: _onItemTapped,
      ),
    );
  }
  void logout() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    // var res = await Network().getData('/logout');
    localStorage.remove(token);
    //var status = res.contains('succes');
    // print(status);

    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => Login()
      ),
    );

  }
}