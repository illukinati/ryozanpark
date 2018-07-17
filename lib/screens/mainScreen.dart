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

enum Answer { YES, NO }

class _MainScreenState extends State<MainScreen> {
  var facilities = [
    "available",
    "available",
    "available",
    "available",
    "available",
    "available",
    "available",
    "available",
    "available",
    "available"
  ];
  var colorFacilities = [
    Colors.green[400],
    Colors.green[400],
    Colors.green[400],
    Colors.green[400],
    Colors.green[400],
    Colors.green[400],
    Colors.green[400],
    Colors.green[400],
    Colors.green[400],
    Colors.green[400]
  ];

  var nameFacilites = ["", "", "", "", "", "", "", "", "", ""];

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull("http://puskesmasdampit.com/rzp/service_watch.php"),
        headers: {"Accept": "application/json"});

    var resBody = JSON.decode(response.body);
    setState(() {
      for (int i = 0; i < facilities.length; i++) {
        if (resBody[i]["status"] == "available") {
          facilities[i] = "利用可能";
          colorFacilities[i] = Colors.green[400];
          nameFacilites[i] = "";
        } else {
          facilities[i] = "利用不可";
          colorFacilities[i] = Colors.red[400];
          nameFacilites[i] = resBody[i]["user"];
        }
      }
    });
    return 'Success!!';
  }

  Future<String> changeStatus(int id, String status) async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "http://puskesmasdampit.com/rzp/service_room.php?id_room=$id&username=${widget.name}"),
        headers: {"Accept": "application.json"});

    var resBody = JSON.decode(response.body);
    setState(() {
          facilities[id - 1] = resBody["status"];
        });  
    await getData();
    return "Successs";
  }
  
  Future<Null> _askUser(int id) async {
    String status = (this.facilities[id - 1] == "利用可能") ? "on" : "off";
    switch (await showDialog(
      context: context,
      child: new SimpleDialog(
        title: new Text("Do you want to turn it $status ?"),
        children: <Widget>[
          new SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, Answer.YES);
            },
            child: const Text("Yes"),
          ),
          new SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, Answer.NO);
            },
            child: const Text("No"),
          )
        ],
      ),
    )) {
      case Answer.YES:
        {
          changeStatus(id, status);
          break;
        }
      case Answer.NO:
        {
          break;
        }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
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
                              child: new InkWell(
                                onTap: () {
                                  getData();
                                },
                                child: new Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      0.0, 10.0, 10.0, 0.0),
                                  alignment: Alignment.centerRight,
                                  child: new Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ),
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
                                  child: new GestureDetector(
                                    onTap: () => _askUser(1),
                                    child: new ItemFacility(
                                      number: "1",
                                      itemColor: this.colorFacilities[0],
                                      available: this.facilities[0],
                                      name: this.nameFacilites[0],
                                    ),
                                  ),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new GestureDetector(
                                    onTap: () => _askUser(2),
                                    child: new ItemFacility(
                                      number: "2",
                                      itemColor: this.colorFacilities[1],
                                      available: this.facilities[1],
                                      name: this.nameFacilites[1],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  flex: 1,
                                  child: new GestureDetector(
                                    onTap: () => _askUser(3),
                                    child: new ItemFacility(
                                      number: "3",
                                      itemColor: this.colorFacilities[2],
                                      available: this.facilities[2],
                                      name: this.nameFacilites[2],
                                    ),
                                  ),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new GestureDetector(
                                    onTap: () => _askUser(4),
                                    child: new ItemFacility(
                                      number: "4",
                                      itemColor: this.colorFacilities[3],
                                      available: this.facilities[3],
                                      name: this.nameFacilites[3],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  flex: 1,
                                  child: new GestureDetector(
                                    onTap: () => _askUser(5),
                                    child: new ItemFacility(
                                      number: "5",
                                      itemColor: this.colorFacilities[4],
                                      available: this.facilities[4],
                                      name: this.nameFacilites[4],
                                    ),
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
                                  child: new GestureDetector(
                                    onTap: () => _askUser(6),
                                    child: new ItemFacility(
                                      number: "1",
                                      itemColor: this.colorFacilities[5],
                                      available: this.facilities[5],
                                      name: this.nameFacilites[5],
                                    ),
                                  ),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new GestureDetector(
                                    onTap: () => _askUser(7),
                                    child: new ItemFacility(
                                      number: "2",
                                      itemColor: this.colorFacilities[6],
                                      available: this.facilities[6],
                                      name: this.nameFacilites[6],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  flex: 1,
                                  child: new GestureDetector(
                                    onTap: () => _askUser(8),
                                    child: new ItemFacility(
                                      number: "3",
                                      itemColor: this.colorFacilities[7],
                                      available: this.facilities[7],
                                      name: this.nameFacilites[7],
                                    ),
                                  ),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new Container(),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: new GestureDetector(
                                    onTap: () => _askUser(9),
                                    child: new ItemFacility(
                                      number: "4",
                                      itemColor: this.colorFacilities[8],
                                      available: this.facilities[8],
                                      name: this.nameFacilites[8],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  flex: 1,
                                  child: new GestureDetector(
                                    onTap: () => _askUser(10),
                                    child: new ItemFacility(
                                      number: "5",
                                      itemColor: this.colorFacilities[9],
                                      available: this.facilities[9],
                                      name: this.nameFacilites[9],
                                    ),
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
                                image:
                                    new AssetImage("assets/images/guitar.png"),
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
          ),
          new Expanded(
            flex: 1,
            child: new Divider(),
          ),
          new Text(
            this.name,
            style: new TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
