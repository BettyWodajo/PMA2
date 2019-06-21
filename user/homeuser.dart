import 'package:flutter/material.dart';
import 'package:flutterpma/both/comment_model.dart';
import 'package:flutterpma/expert/login.dart';
import 'package:flutterpma/reminder/database/db_handler.dart';
import 'package:flutterpma/reminder/database/settings_model.dart';
import 'package:flutterpma/reminder/widgets/coming_stuff.dart';
import 'package:flutterpma/reminder/widgets/settings.dart';
import 'package:flutterpma/user/expert.dart';
import 'package:flutterpma/webview/chat_webview.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutterpma/expert/chat.dart';
// import 'package:testflutter/pages/resource/resource_webview.dart';
import 'dart:convert';

// import 'package:testflutter/reminder/widgets/coming_stuff.dart';
// import 'package:testflutter/home.dart';
// import 'package:testflutter/reminder/widgets/coming_stuff.dart';
import 'package:flutterpma/reminder/util/dictionnary.dart' as dictionnary;
// import 'package:testflutter/reminder/database/db_handler.dart';
// import 'package:testflutter/reminder/database/settings_model.dart';

class HomePageUser extends StatefulWidget {
  String email;
  var userinfo;
  HomePageUser({this.email,this.userinfo});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageUserState();
  }
}

class HomePageUserState extends State<HomePageUser> {
  // static final resourceurl = 'http://10.0.2.2:8000/api/resources';
  static final url = 'http://'+url+':8000/api/blog';
  static final commentposturl = 'http://'+url+':8000/api/comment';

  static final jsonplacholder = 'https://jsonplaceholder.typicode.com/posts';
  static final CREATE_POST_URL = 'http://'+url+':8000/api/auth/login';
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

  List data;
  var test;
  Future<String> getData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    this.setState(() {
      // test = jsonDecode(response.body);
      data = jsonDecode(response.body);
      test = jsonDecode(response.body);
    });
    // print(widget.userinfo['user']['id']);
    // print( data[1]['comments']);
    // print( test.toString().matchAsPrefix('idff'));

    return "sccess";
  }

  Future<Comment> createComment(String url, {Map body}) async {
    var data;

    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      data = jsonDecode(response.body);
      //save the access toke everytime
      print(data.toString());
      // print( data['comments'].toString().startsWith('text'));
      // print(data['user']['role']);
      // print(response.body.contains(''));

      return Comment.fromJson(json.decode(response.body));
    });
  }
  //   List commentlist;
  // Future<String> getComment() async {
  //   var response = await http.get(Uri.encodeFull(url),
  //       headers: {"Accept": "application/json"});
  //   this.setState(() {
  //     // test = jsonDecode(response.body);
  //     data = jsonDecode(response.body);
  //   });
  //   print(data);
  //   return "sccess";
  // }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
     var _value = "1";

  DropdownButton _normalDown() => DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            value: "1",
            child: Text(
              "First",
            ),
          ),
          DropdownMenuItem<String>(
            value: "2",
            child: Text(
              "Second",
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
      );
    Color greencolor = Color(0xFF26C6DA);
    debugHighlightDeprecatedWidgets = false;

    Widget resourcecard;
    var now = DateTime.now();
    // TODO: implement build
    
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Color(0xFF26C6DA),
                automaticallyImplyLeading: false,
                title: Text(widget.email),
                elevation: 13,
                actions: <Widget>[
                 Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              // color: Colors.blue,
              child:      FlatButton(
             child: Icon(Icons.settings, color: Colors.white),
             onPressed: _showSettings,
           ),
            ),
                ],
              ),
              // ListTile(
              //   title: Text(dictionnary.translate('chat')),
              //   trailing: Icon(Icons.chat),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         new MaterialPageRoute(
              //             // builder: (context) => HomePageUser('user'),
              //             builder: (context) => ChatPageWebView()));
              //     // Navigator.pushNamed(context, '/chat');
              //   },
              // ),
              ListTile(
                title: Text(dictionnary.translate('First.aid.kit')),
                trailing: SizedBox(
                  child: Image.asset('assets/emergency-kit.png'),
                  height: 30,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/firstaidkit');
                },
              ),
              ListTile(
                title: Text(dictionnary.translate('Available.Experts') ),
                trailing: SizedBox(
                  child: Image.asset('assets/doctor.png'),
                  height: 30,
                ),
                onTap: () {
                   Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      // builder: (context) => HomePageUser('user'),
                                      builder: (context) => Expertpage(userinfo:widget.userinfo
                                          )));
                },
              ),

              ListTile(
                title: Text(dictionnary.translate('Reminder')),
                trailing: Icon(Icons.alarm),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new MaterialApp(
                                theme: ThemeData(primarySwatch: Colors.green),
                                home: new ComingStufWidget(),
                              )));
                },
              ),
              ListTile(
                title: Text(dictionnary.translate('Medical.library')),
                trailing: Icon(Icons.library_add),
                onTap: () {
                  Navigator.pushNamed(context, '/medicallibrary');
                },
              ),

              // ListTile(
              //   title: Text("FAQ"),
              //   trailing: Icon(Icons.chat_bubble),
              //   onTap: () {},
              // ),
              // Navigator.pop(context, Login());
              ListTile(
                title: Text(dictionnary.translate('Logout')),
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pushNamed(context, '/loginexpert');
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF26C6DA),
          actions: <Widget>[
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.search),
            // )
          ],
        ),
        // appBar: AppBar(automaticallyImplyLeading: false),

        body: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data == null ? 0 : data.length,
            // itemCount: data.length,
            itemBuilder: _buildResource));
  }

  Widget _buildResource(BuildContext context, int index) {
       TextEditingController userid = new TextEditingController();
    // TextEditingController blogid = new TextEditingController();
    // String userid = "1";
    String blogid = "1";
    TextEditingController text = new TextEditingController();
    TextEditingController comment = new TextEditingController();
    String dummy =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';

    double c_width = MediaQuery.of(context).size.width * 0.8;
    double c_height = MediaQuery.of(context).size.height * 0.8;
    final _formKey = GlobalKey<FormState>();

    Color greencolor = Color(0xFF26C6DA);

    var now = DateTime.now();
    TextEditingController _controller = new TextEditingController();
    int maxLength = 55;

    return new Container(
      // margin: EdgeInsets.all(10),

      margin: EdgeInsets.fromLTRB(15, 55, 25, 15),
      height: 500,
      width: c_width,
      // child: ListView(
      //   scrollDirection: Axis.vertical,
      //   children: <Widget>[
      child: Card(
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),

        elevation: 25,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            SizedBox(
                // width: 400,
                // child: Image.asset('assets/placeholder.jpg')
                // child: Image.network(data[index]['img']),
                child: new FadeInImage(
                    image: new NetworkImage(data[index]['header']),
                    placeholder: new AssetImage('assets/hospital.jpg'))),
            Container(
              padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
              child: Text(
                // 'test',
                data[index]['header'],
                style: TextStyle(fontSize: 25, color: greencolor),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              width: c_width,
              padding: EdgeInsets.symmetric(horizontal: 5),
              margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Text(
                data[index]['body'],
                // dummy,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
              child: Text(
                // "time",
                //  textAlign: TextAlign.left,
                // "posted " +
                //     // data[index]['created_at'].toString() ,
                //     // DateTime.now().timeZoneName.toString(),
                DateTime.parse(data[index]['created_at']).toLocal().toString(),
              ),
            ),
            Container(
                width: c_width,
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(child: Text(widget.email.substring(0, 1))),
                    SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   data[index]['comments'].toString(),
                    //   textAlign: TextAlign.left,
                    //   style: TextStyle( color: greencolor, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                    // )
                  ],
                )),
            // Container(child:  Row(children: <Widget>[
            //   Text(widget.email),  SizedBox(width: 10,),

            // ]),constraints: BoxConstraints(maxHeight: 50,maxWidth: 100),margin: EdgeInsets.fromLTRB(0, 50, 0, 0),),
            new Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.white,
                child: new Container(
                  child: new Form(
                    // key: _formKey,
                    child: new Column(children: [
                      //  new Padding(padding: EdgeInsets.only(top: 140.0)),
                      //  new Text('Beautiful Flutter TextBox',
                      //  style: new TextStyle(color: Colors.blue, fontSize: 25.0),),
                      //  new Padding(padding: EdgeInsets.only(top: 50.0)),
                      new TextFormField(
                        controller: comment,
                        decoration: new InputDecoration(
                          labelText: "Enter Comment",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "Email cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.multiline,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      // TextFormField(,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          color: greencolor,
                          onPressed: () async {
                            Comment newPost = new Comment(
                                user_id: widget.userinfo['user']['id'].toString(),
                                blog_id: blogid,
                                text: comment.text);
                            Comment p = await createComment(commentposturl,
                                body: newPost.toMap());
                            getData();
                            // print((data[index]['comments']
                            //     .toString().indexOf('text')));

                            //        return showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return AlertDialog(
                            //       // Retrieve the text the user has typed in using our
                            //       // TextEditingController
                            //       content: Text(comment.text),
                            //     );
                            //   },
                            // );
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ]),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

void initLang() async {
  dictionnary.lang = 'en';
  final dbh = DatabaseHandler.internal();
  Settings settings = await dbh.readSettings();
  dictionnary.lang = (settings.lang == null) ? 'en' : settings.lang;
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}
