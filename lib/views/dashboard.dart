import 'package:digital/languesImpl/app_localizations.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget{
  @override
  _DashboardState createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard>{

  ThemeData theme;
  bool refresh = false;
  double scaleFactor = 1;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      body: new ListView(
        children: <Widget>[
               Image( height: 150*scaleFactor,
                      width: 150*scaleFactor,
                      image: AssetImage('images/digital.png'),
                    ),
                    SizedBox(height: 16*scaleFactor,),
          new Padding(padding: const EdgeInsets.all(40.0),
            child: new Text(buildTranslate(context, 'Description'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),),




          new Container(

              child: Row(
                children: <Widget>[
                  Padding( padding: EdgeInsets.all(20.0)),
                  Icon(Icons.email),
                  Text('  contact@DigitalAdvisor.ma', style: TextStyle(fontSize: 15),),
                ],
              )

          ),
          new Container(

              child: Row(
                children: <Widget>[
                  Padding( padding: EdgeInsets.all(20.0)),
                  Icon(Icons.phone,color: Colors.deepOrangeAccent,),
                  Text('  0675465743',  style: TextStyle(fontSize: 15),),
                ],
              )

          ),
        ],
      ),
      
      ),
    );
  }

}