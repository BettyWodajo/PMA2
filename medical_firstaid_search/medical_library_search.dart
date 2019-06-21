import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpma/expert/chat.dart';
import 'package:flutterpma/reminder/database/db_handler.dart';
import 'package:flutterpma/reminder/database/settings_model.dart';
import 'package:flutterpma/reminder/widgets/settings.dart';
import 'package:flutterpma/webview/chat_webview.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutterpma/reminder/util/dictionnary.dart' as dictionnary;

// void main() => runApp(new MaterialApp(
//   home: new HomePage(),
//   debugShowCheckedModeBanner: false,
// ));

class MedicalLibrarySearch extends StatefulWidget {
  @override
  MedicalLibrarySearchState createState() => new MedicalLibrarySearchState();
}

class MedicalLibrarySearchState extends State<MedicalLibrarySearch> {
  var data;

  TextEditingController controller = new TextEditingController();
  double rating = 3;
  String _selectedLang;
  final dbh = DatabaseHandler.internal();
  void _saveSettings() async {
    Settings settings = await dbh.readSettings();
    settings.lang = _selectedLang;
    dbh.saveSettings(settings);
    dictionnary.lang = _selectedLang;
    setState(() {});
  }

  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final response = await http.get(experturl);
    final responseJson = json.decode(response.body);
    data = json.decode(response.body);

    setState(() {
      for (Map user in responseJson) {
        if (_userDetails
            .toString()
            .startsWith(UserDetails.fromJson(user).toString())) {
          return Center(
            child: Text('already has data '),
          );
        } else
          _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // print(widget.userinfo['user']['id']);

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    Color greencolor = Color(0xFF26C6DA);
    var isA = true;
    var isB = true;

    Widget _expandable(BuildContext context, int index) {
      List description = json.decode(_userDetails[index].description);
      String descriptionString = '';
      double c_width = MediaQuery.of(context).size.width * 0.8;

      // List<Widget> widgets = description.map((name) => new Text(name)).toList();
      //
      //  var  sum = 0 ;
      //  String desc ;
      //           for(var i = 0; i<description.length;i++){
      //             sum =
      //                     desc =  description[i++].toString();

      //           }
      //                     print(desc);

      //           }
      String descriptionFunction() {
        description.forEach((element) {
          print(element);

          return element;
        });
      }

      var alert = AlertDialog(title: Text(descriptionFunction().toString()));

      return new Card(
        child: new Column(
          children: <Widget>[
            ExpansionPanelList(
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isE) => Container(
                        child: Text(_userDetails[index].name.toString()[0],
                            style: TextStyle(fontSize: 22)),
                      ),
                  body: Container(
                    color: Colors.greenAccent,
                    constraints: BoxConstraints.expand(height: 250),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text(_userDetails[index].name,
                            style: TextStyle(fontSize: 22)),
                        ListTile(
                          leading: Icon(Icons.arrow_right),
                          title: Text(_userDetails[index].symptom,
                              style: TextStyle(fontStyle: FontStyle.italic)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Center(
                        //     child: Text(
                        //   'description',
                        //   style: TextStyle(fontSize: 22),
                        // )),
                        Container(
                          margin: new EdgeInsets.fromLTRB(200, 0, 0, 0),
                          child: RaisedButton(
                            color: Colors.greenAccent,
                            onPressed: () async {
                              description.forEach((element) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0))),
                                            content: Container(
                                              width: c_width,
                                              height: 400,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      Text(
                                                        element['name']
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow:
                                                            TextOverflow.fade,
                                                      ),
                                                    ],
                                                  ),
                                                  // RaisedButton(child: Text('back'),onPressed: (){
                                                  //         Navigator.pop(context);
                                                  //   },)
                                                ],
                                              ),
                                            ),
                                            title:
                                                Text("Disease Description")));

                                print(element);

                                return element;
                              });
                            },
                            child: Text(
                              'Description',
                              style: TextStyle(),
                            ),
                          ),
                        ),

                        // Text("dsaf"),
                        Container(
                          margin: EdgeInsets.fromLTRB(200, 0, 0, 0),
                          child: GestureDetector(
                            child: CircleAvatar(
                              radius: 20,
                              child: Image.asset('assets/youtube.png'),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/youtube');
                              //  return alert;
                              //  showDialog(context: context, builder: (BuildContext context) => alert);
                            },
                          ),
                        )
                        // ListTile(
                        //   leading: Icon(Icons.arrow_right),
                        //   title: Text(description[1]['name'],
                        //       style: TextStyle(fontStyle: FontStyle.italic)),
                        // ),
                      ],
                    ),
                  ),
                  isExpanded: isA,
                )
              ],
              expansionCallback: (ind, isE) {
                print("index: $ind, isE: $isE");

                setState(() {
                  if (ind == 0) {
                    isA = !isE;
                  } else
                    isB = !isE;
                });
              },
            )
          ],
        ),
      );
    }

    Widget _expandableSearch(BuildContext context, int index) {
      List description = json.decode(_userDetails[index].description);
      // String descriptionString = '';
      double c_width = MediaQuery.of(context).size.width * 0.8;
      return new Card(
        child: new Column(
          children: <Widget>[
            ExpansionPanelList(
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isE) => Container(
                        child: Text(_searchResult[index].name.toString()[0],
                            style: TextStyle(fontSize: 22)),
                      ),
                  body: Container(
                    color: Colors.greenAccent,
                    constraints: BoxConstraints.expand(height: 300),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text(_searchResult[index].name,
                            style: TextStyle(fontSize: 22)),
                        ListTile(
                          leading: Icon(Icons.arrow_right),
                          title: Text(_searchResult[index].symptom,
                              style: TextStyle(fontStyle: FontStyle.italic)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: new EdgeInsets.fromLTRB(200, 0, 0, 0),
                          child: RaisedButton(
                            color: Colors.greenAccent,
                            onPressed: () async {
                              description.forEach((element) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0))),
                                            content: Container(
                                              width: c_width,
                                              height: 400,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      ListTile(
                          leading: Icon(Icons.arrow_right),
                          title:  Text(
                                                        element['name']
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow:
                                                            TextOverflow.fade,
                                                      ),
                        ),
                                                     
                                                    ],
                                                  ),
                                                  // RaisedButton(child: Text('back'),onPressed: (){
                                                  //         Navigator.pop(context);
                                                  //   },)
                                                ],
                                              ),
                                            ),
                                            title:
                                                Text("Disease Description")));

                                print(element);

                                return element;
                              });
                            },
                            child: Text(
                              'Description',
                              style: TextStyle(),
                            ),
                          ),
                        ),
                         
                      ],
                    ),
                  ),
                  isExpanded: isA,
                )
              ],
              expansionCallback: (ind, isE) {
                print("index: $ind, isE: $isE");

                setState(() {
                  if (ind == 0) {
                    isA = !isE;
                  } else
                    isB = !isE;
                });
              },
            )
          ],
        ),
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(dictionnary.translate('Medical.library')),
        elevation: 0.0,
        backgroundColor: greencolor,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: greencolor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: dictionnary.translate('Search'),
                        border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? new Scaffold(
                    body: ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, i) {
                        return _expandableSearch(context, i);
                      },
                    ),
                  )
                : new ListView.builder(
                    itemCount: _userDetails.length,
                    itemBuilder: _expandable,
                  ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.name.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }

  void _showAlert() {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 230.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // dialog top
            new Expanded(
              child: new Row(
                children: <Widget>[
                  new Container(
                    // padding: new EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                    ),
                    child: new Text(
                      'Rate',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'helvetica_neue_light',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // dialog centre
            new Expanded(
              child: new Container(
                  child: new TextField(
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  filled: false,
                  contentPadding: new EdgeInsets.only(
                      left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                  hintText: ' add review',
                  hintStyle: new TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                ),
              )),
              flex: 2,
            ),

            // dialog bottom
            new Expanded(
              child: new Container(
                padding: new EdgeInsets.all(16.0),
                decoration: new BoxDecoration(
                  color: const Color(0xFF33b17c),
                ),
                child: new Text(
                  'Rate product',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(context: context, child: dialog);
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

final String url = 'https://jsonplaceholder.typicode.com/users';
final String experturl = 'http://'+url+':8000/api/diseases';

class UserDetails {
  final int id;
  final String name, symptom, description;

  UserDetails({
    this.id,
    this.name,
    this.symptom,
    this.description,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      id: json['id'],
      name: json['name'],
      symptom: json['symptom'],
      description: json['description'],
    );
  }
}
