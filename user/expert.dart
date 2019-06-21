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

class Expertpage extends StatefulWidget {
  var userinfo;
  Expertpage ({this.userinfo});
  @override
  ExpertPageState createState() => new ExpertPageState();
}

class ExpertPageState extends State<Expertpage> {
  var data;

  TextEditingController controller = new TextEditingController();
  double rating = 3;
   String _selectedLang;
    final dbh = DatabaseHandler.internal();
    void _saveSettings() async{
    Settings settings = await dbh.readSettings();
    settings.lang = _selectedLang;
    dbh.saveSettings(settings);
    dictionnary.lang = _selectedLang;
    setState(() {});
  }
   void _showSettings(){
    var alert = AlertDialog(
      title: Text(dictionnary.translate('settings')),
      content: SettingsWidget(
        selectedLang: dictionnary.lang,
        onDataChanged: (lang) => _selectedLang = lang,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(dictionnary.translate('save')),
          onPressed: () {
            _saveSettings();
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(dictionnary.translate('cancel')),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final response = await http.get(experturl);
    final responseJson = json.decode(response.body);
      data = json.decode(response.body);
    setState(() {
      for (Map user in responseJson) {
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

    final int value = 1;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(dictionnary.translate('Experts')),
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
                        hintText: dictionnary.translate('Search'), border: InputBorder.none),
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
                ? new ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, i) {
                      return new Card(
                        child: Column(
                          children: <Widget>[
                            new ListTile(
                              leading: new CircleAvatar(
                                  child: RaisedButton(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPressed: () {
                                 Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      // builder: (context) => HomePageUser('user'),
                                      builder: (context) => 
                                      ChatPageWebView(
                                        from:widget.userinfo['user']['id'],to:_userDetails[i].id
                                          )));
                                },
                                child: Icon(
                                  Icons.chat,
                                  color: greencolor,
                                ),
                              )),
                              title: new Text(_searchResult[i].fullname +
                                  ' ' +
                                  _searchResult[i].address),
                            ),
                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: List.generate(4, (index) {
                            //     return Icon(
                            //       index < value
                            //           ? Icons.star
                            //           : Icons.star_border,
                            //     );
                            //   }),
                            // )
                              Container(child: GestureDetector(child: Text("review"),onTap: (){
                                openAlertBox();
                              },),)
                          ],
                        ),
                        margin: const EdgeInsets.all(0.0),
                      );
                    },
                  )
                : new ListView.builder(
                    itemCount: _userDetails.length,
                    itemBuilder: (context, index) {
                      return new Card(
                        child: new ListTile(
                          leading: new CircleAvatar(
                              child: RaisedButton(
                                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      // builder: (context) => HomePageUser('user'),
                                      builder: (context) => 
                                      ChatPageWebView(from:widget.userinfo['user']['id'],to:_userDetails[index].id
                                          )));
                            },
                            child: Icon(Icons.chat,color: greencolor,),
                          )),
                          title: new Text(_userDetails[index].fullname +
                              ' ' +
                              _userDetails[index].address),
                        ),
                        margin: const EdgeInsets.all(0.0),
                      );
                    },
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
      if (userDetail.fullname.contains(text) ||
          userDetail.address.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Rate",
                        style: TextStyle(fontSize: 24.0),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.star_border,
                            color: Colors.greenAccent,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.greenAccent,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.greenAccent,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.greenAccent,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.greenAccent,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Add Review",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Rate Doctor",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

final String url = 'https://jsonplaceholder.typicode.com/users';
final String experturl = 'http://'+url+':8000/api/expert';

class UserDetails {
  final int id;
  final String fullname, address, profileUrl;

  UserDetails(
      {this.id,
      this.fullname,
      this.address,
      this.profileUrl =
          'https://www.rd.com/wp-content/uploads/2017/09/02_doctor_Insider-Tips-to-Choosing-the-Best-Primary-Care-Doctor_519507367_Stokkete.jpg'});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      id: json['id'],
      fullname: json['full_name'],
      address: json['address'],
    );
  }
}
