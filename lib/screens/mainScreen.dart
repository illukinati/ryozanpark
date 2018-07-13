import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final String name;

  MainScreen({this.name});

  @override
  _MainScreenState createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "http://puskesmasdampit.com/rzp/service_watch.php"),
        headers: {"Accept": "application/json"});

    var resBody = JSON.decode(response.body);
    return 'Success!!';
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Ryozan Park Facilities"),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 10.0),
                child: new Card(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        color: Colors.blue[200],
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              margin: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 0.0, 0.0),
                              child: new Image(
                                width: 30.0,
                                height: 30.0,
                                image:
                                    new AssetImage("assets/images/laundry.png"),
                              ),
                            ),
                            new Container(
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 0.0, 0.0),
                              child: new Text(
                                "ランドリー (Laundry)",
                                style: new TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            new Expanded(
                              flex: 1,
                              child: new Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 10.0, 0.0),
                                alignment: Alignment.centerRight,
                                child: new Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      new Row(
                        children: <Widget>[
                          new Expanded(
                              flex: 1,
                              child: new Container(
                                height: 2.0,
                                color: Colors.grey[500],
                              ))
                        ],
                      ),
                      new Container(
                        padding: const EdgeInsets.all(25.0),
                        child: new Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  flex: 1,
                                  child: new ItemFacility(
                                    number: "1",
                                    itemColor: Colors.green[400],
                                    available: "利用可能",
                                  ),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new ItemFacility(
                                    number: "2",
                                    itemColor: Colors.green[400],
                                    available: "利用可能",
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  flex: 1,
                                  child: new ItemFacility(
                                    number: "3",
                                    itemColor: Colors.green[400],
                                    available: "利用可能",
                                  ),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new ItemFacility(
                                    number: "4",
                                    itemColor: Colors.green[400],
                                    available: "利用可能",
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  flex: 1,
                                  child: new ItemFacility(
                                    number: "5",
                                    itemColor: Colors.red[400],
                                    available: "利用不可",
                                  ),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 25.0),
                child: new Card(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        color: Colors.orange[200],
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              margin: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 0.0, 0.0),
                              child: new Image(
                                width: 30.0,
                                height: 30.0,
                                image: new AssetImage("assets/images/sun.png"),
                              ),
                            ),
                            new Container(
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 0.0, 0.0),
                              child: new Text(
                                "乾燥機 (Dryer Machine)",
                                style: new TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            new Expanded(
                              flex: 1,
                              child: new Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 10.0, 0.0),
                                alignment: Alignment.centerRight,
                                child: new Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      new Row(
                        children: <Widget>[
                          new Expanded(
                              flex: 1,
                              child: new Container(
                                height: 2.0,
                                color: Colors.grey[500],
                              ))
                        ],
                      ),
                      new Container(
                        padding: const EdgeInsets.all(25.0),
                        child: new Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  flex: 1,
                                  child: new ItemFacility(
                                    number: "1",
                                    itemColor: Colors.red[400],
                                    available: "利用不可",
                                  ),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new ItemFacility(
                                    number: "2",
                                    itemColor: Colors.green[400],
                                    available: "利用可能",
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  flex: 1,
                                  child: new ItemFacility(
                                    number: "3",
                                    itemColor: Colors.red[400],
                                    available: "利用不可",
                                  ),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new ItemFacility(
                                    number: "4",
                                    itemColor: Colors.red[400],
                                    available: "利用不可",
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  flex: 1,
                                  child: new ItemFacility(
                                    number: "5",
                                    itemColor: Colors.red[400],
                                    available: "利用不可",
                                  ),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 25.0),
                child: new Card(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        color: Colors.purple[200],
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              margin: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 0.0, 0.0),
                              child: new Image(
                                width: 30.0,
                                height: 30.0,
                                image: new AssetImage("assets/images/guitar.png"),
                              ),
                            ),
                            new Container(
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 0.0, 0.0),
                              child: new Text(
                                "ミュージックルーム",
                                style: new TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            new Expanded(
                              flex: 1,
                              child: new Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 10.0, 0.0),
                                alignment: Alignment.centerRight,
                                child: new Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      new Row(
                        children: <Widget>[
                          new Expanded(
                              flex: 1,
                              child: new Container(
                                height: 2.0,
                                color: Colors.grey[500],
                              ))
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Expanded(
                              flex: 1,
                              child: new Container(
                                padding: const EdgeInsets.all(25.0),
                                color: Colors.white,
                                child: new Text("Coming Soon"),
                              ))
                        ],
                      ),
                    ],
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

class ItemFacility extends StatelessWidget {
  final String available;
  final String number;
  final String name;
  final Color itemColor;

  const ItemFacility(
      {Key key, this.name, this.available, this.number, this.itemColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(10.0),
      height: 75.0,
      width: 50.0,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: this.itemColor,
      ),
      child: new Column(
        children: <Widget>[
          new Text(
            this.number,
            style: new TextStyle(
              color: Colors.white,
            ),
          ),
          new Text(
            this.available,
            style: new TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
