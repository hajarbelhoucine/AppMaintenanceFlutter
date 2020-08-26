import 'package:digital/languesImpl/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:digital/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Oscilloscope Display Example",
      home: Shell(),
    );
  }
}

class Shell extends StatefulWidget {
  @override
  _ShellState createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  List<double> traceSine = List();
  List<double> traceCosine = List();
  List<double> traceSineInv = List();
  double radians = 0.0;
  Timer _timer;

  /// method to generate a Test  Wave Pattern Sets
  /// this gives us a value between +1  & -1 for sine & cosine
  _generateTrace(Timer t) {
    // generate our  values
    var sv = sin((radians * pi));
    var cv = cos((radians * pi));
    var tn = -sin((radians * pi));

    // Add to the growing dataset
    setState(() {
      traceSine.add(sv);
      traceCosine.add(cv);
      traceSineInv.add(tn);
    });

    // adjust to recyle the radian value ( as 0 = 2Pi RADS)
    radians += 0.05;
    if (radians >= 2.0) {
      radians = 0.0;
    }
  }

  @override
  initState() {
    super.initState();
    // create our timer to generate test values
    _timer = Timer.periodic(Duration(milliseconds: 60), _generateTrace);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create A Scope Display for Sine



    // Create A Scope Display for Cosine



    // Generate the Scaffold
    return Scaffold(

      body: Column(
        children: <Widget>[

          SizedBox(
            width: 250.0,
            child: ColorizeAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  buildTranslate(context, 'Acceleration -X'),
                  buildTranslate(context, 'Acceleration -Y'),
                  buildTranslate(context, 'Acceleration -Z'),
                ],
                textStyle: TextStyle(
                    fontSize: 25.0,
                    fontFamily: "Horizon"
                ),
                colors: [
                  Colors.purple,
                  Colors.blue,
                  Colors.yellow,
                  Colors.red,
                ],
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
            ),
          ),
          Expanded(flex: 1, child:
       Oscilloscope(
        showYAxis: true,
        yAxisColor: Colors.white,
        padding: 20.0,
        backgroundColor: Colors.black,
        traceColor: Colors.green,
        yAxisMax: 2.0,
        yAxisMin: -2.0,
        dataSet: traceSine,

      ),
          ),
          SizedBox(
            width: 250.0,
            child: ColorizeAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  buildTranslate(context, 'Pitch'),
                  buildTranslate(context, 'Pitch'),


                ],
                textStyle: TextStyle(
                    fontSize: 25.0,
                    fontFamily: "Horizon"
                ),
                colors: [
                  Colors.purple,
                  Colors.blue,
                  Colors.yellow,
                  Colors.red,
                ],
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
            ),
          ),
          Expanded(


            flex: 1, child :

       Oscilloscope(
            showYAxis: true,
            padding: 20.0,
            backgroundColor: Colors.black,
            yAxisColor: Colors.white,
            traceColor: Colors.yellow,
            yAxisMax: 2.0,
            yAxisMin: -2.0,
            dataSet: traceCosine,
          ),

          ),
      SizedBox(
        width: 250.0,
        child: ColorizeAnimatedTextKit(
            onTap: () {
              print("Tap Event");
            },
            text: [
              buildTranslate(context, 'Roll'),
              buildTranslate(context, 'Roll'),


            ],
            textStyle: TextStyle(
                fontSize: 25.0,
                fontFamily: "Horizon"
            ),
            colors: [
              Colors.purple,
              Colors.blue,
              Colors.yellow,
              Colors.red,
            ],
            textAlign: TextAlign.start,
            alignment: AlignmentDirectional.topStart // or Alignment.topLeft
        ),
      ),
          Expanded(
            flex: 1,
            child:  Oscilloscope(
            showYAxis: true,
            padding: 20.0,
            backgroundColor: Colors.black,

            yAxisColor: Colors.white,
            traceColor: Colors.red,
            yAxisMax: 2.0,
            yAxisMin: -2.0,
            dataSet: traceSineInv,
          ),
          ),
        ],
      ),
    );
  }
}