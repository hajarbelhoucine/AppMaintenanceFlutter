import 'package:flutter/material.dart';
import 'package:digital/network_utils/api.dart';
import 'package:digital/views/machines.dart';
class MachineDetail extends StatelessWidget {
  List list;

  //PostDetail({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("details"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text("id"),
                        // subtitle: new Text('State : ${list[i]['state']}'),
                      ),
                      ListTile(
                        title: Text("name"),
                        // subtitle: Text("${post.id}"),
                      ),
                      ListTile(
                        title: Text("Category"),
                        // subtitle: Text(post.category),
                      ),
                      ListTile(
                        title: Text("created_at"),
                        // subtitle: Text("${post.created_at}"),
                      ),
                    ],
                  ),
                ),

                new RaisedButton(
                  child: new Text('Show Graph '),

                )

              ],
            ),
          ),
        ));
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MachineDetail(
                      ),
                    ),
                  ),
                ),
              )
              ,
            ),
          );

        }
    );
  }

}