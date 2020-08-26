import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:digital/network_utils/api.dart';
import 'dart:convert';

class GraphMachine extends StatefulWidget {
  final int id;

  GraphMachine({Key key, @required this.id}) : super(key: key);

  _GraphMachineState createState() => _GraphMachineState();
}

class _GraphMachineState extends State<GraphMachine> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    _seriesGraphData = List<charts.Series<Graph, DateTime>>();
    _generateData();


  }
  @override
  void setState(fn) {
    if(mounted){
      getgraph(widget.id);
      super.setState(fn);
    }
  }


  List<charts.Series<Graph, DateTime>> _seriesGraphData;

  _generateData() {


  }




  getgraph(id) async{
    var res = await Network().getData('/machines/$id/stats');

    var xa = [];
    var ya = [];
    var za = [];
    for(int i=0;i<res.length;i++){
      print(res[i]['xa']);

      xa.add(new Graph( DateTime.parse( res[i]['created_at']),double.parse(res[i]['xa'])));
      ya.add(new Graph(DateTime.parse( res[i]['created_at']),double.parse(res[i]['ya'])));
      za.add(new Graph(DateTime.parse(res[i]['created_at']),double.parse(res[i]['za'])));
    }
    print(xa[0].date.getMinutes());

    _seriesGraphData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: xa,
        domainFn: (Graph graph, _) => graph.date,
        measureFn: (Graph graph, _) => graph.val,
      ),
    );
    _seriesGraphData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: ya,
        domainFn: (Graph graph, _) => graph.date,
        measureFn: (Graph graph, _) => graph.val,
      ),
    );
    _seriesGraphData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: za,
        domainFn: (Graph graph, _) => graph.date,
        measureFn: (Graph graph, _) => graph.val,
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(

            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.solidChartBar),
                ),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: Text('Machine ${widget.id}'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'SO₂ emissions, by world region (in million tonnes)',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Time spent on daily tasks',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10.0,),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Sales for the first 5 years',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                        Expanded(
                          child: charts.TimeSeriesChart(
                              _seriesGraphData,
                              defaultRenderer: new charts.LineRendererConfig(
                                  includeArea: true, stacked: true),
                              animate: true,
                              animationDuration: Duration(seconds: 5),
                              behaviors: [
                                new charts.ChartTitle('Years',
                                    behaviorPosition: charts.BehaviorPosition.bottom,
                                    titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('Sales',
                                    behaviorPosition: charts.BehaviorPosition.start,
                                    titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('Departments',
                                  behaviorPosition: charts.BehaviorPosition.end,
                                  titleOutsideJustification:charts.OutsideJustification.middleDrawArea,
                                )
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Graph {
  DateTime date;
  double val;
  Graph(this.date,this.val);
}