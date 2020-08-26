import 'package:flutter/material.dart';
import 'package:digital/network_utils/api.dart';

import 'MachineDetail.dart';
import 'graph.dart';


class Machines extends StatelessWidget {
  final  categorie;
  Machines({Key key, @required this.categorie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categorie),
        ),
        body: new FutureBuilder<List>(
          future: Network().getData('/machines/categories/$categorie'),
          builder: (context ,snapshot){
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new ItemList(list: snapshot.data)
                : new Center(child: new CircularProgressIndicator(),);
          },
        )
    );
  }
}
class ItemList extends StatelessWidget {

  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list==null?0:list.length,
        itemBuilder: (context,i){
          return new Container(
            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              child: new Card(
                child: new ListTile(
                    title: new Text(list[i]['name']),
                    leading: new Icon(Icons.apps),
                    subtitle: new Text('State : ${list[i]['state']}'),
                    onTap: () {
                      print(list[i]['id']);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GraphMachine(id: list[i]['id']),


                        ),
                      );

                    }
                ),
              )
              ,
            ),
          );

        }
    );
  }

}
