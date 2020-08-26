import 'dart:convert';

import 'package:digital/languesImpl/app_localizations.dart';
import 'package:digital/network_utils/api.dart';
import 'package:flutter/material.dart';

import 'machines.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Categories extends StatelessWidget {

  Categories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new FutureBuilder<List>(
          future: Network().getData('/machines/cats'),
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
  final _formKey = GlobalKey<FormState>();
  var name;
  var category;

  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column( children: <Widget>[
        Expanded(
          child:ListView.builder(
              itemCount: list==null?0:list.length,
              itemBuilder: (context,i){
                return new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new GestureDetector(
                    child: new Card(
                      child: new ListTile(
                          title: new Text(list[i]),
                          leading: new Icon(Icons.apps),
                          onTap: () {
                            print(list[i]);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>Machines(categorie: list[i]),


                              ),
                            );

                          }
                      ),
                    )
                    ,
                  ),

                );

              }
          ),),
      ]
      ),
      floatingActionButton: FloatingActionButton(


          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
          child: Icon(Icons.add),

          onPressed: () =>


              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20.0)), //this right here
                      child: Container(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.category),

                                      hintText:   buildTranslate(context, 'Enter machine name')
                                  ),
                                  validator: (nameValue) {
                                    if (nameValue.isEmpty) {
                                      return 'Please enter name';
                                    }
                                    name = nameValue;
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.category),
                                      hintText: buildTranslate(context, 'Enter machine category')
                                  ),
                                  validator: (catValue) {
                                    if (catValue.isEmpty) {
                                      return 'Please enter category';
                                    }
                                    category = catValue;
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  width: 320.0,
                                  child: RaisedButton(

                                    onPressed: () {

                                      if (_formKey.currentState.validate()) {
                                        print(name);
                                        print(category);
                                        _addMachine();
                                      }

                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      buildTranslate(context, 'Add'),
                                      style: TextStyle(color: Colors.white),

                                    ),

                                    color: const Color(0xFF1BC0C5),

                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              )


      ),
    );
  }
  void _addMachine() async{

    var data = {
      'name': name,
      'category' : category,
    };

    var res = await Network().authData(data, '/machines');

    var body = json.decode(res.body);
    print(body);

  }
}
