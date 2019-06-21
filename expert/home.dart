import 'package:flutter/material.dart';
import 'package:flutterpma/both/comment_model.dart';
import 'package:flutterpma/expert/blog.dart';
import 'package:flutterpma/expert/login.dart';
import 'package:flutterpma/reminder/database/db_handler.dart';
import 'package:flutterpma/reminder/database/settings_model.dart';
import 'package:flutterpma/reminder/widgets/coming_stuff.dart';
import 'package:flutterpma/reminder/widgets/settings.dart';
import 'package:flutterpma/webview/expert_chat_list.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutterpma/expert/chat.dart';
import '../reminder/util/dictionnary.dart' as dictionnary;

// import 'package:testflutter/pages/resource/resource_webview.dart';
import 'dart:convert';

// import 'package:testflutter/reminder/widgets/coming_stuff.dart';
// import 'package:testflutter/home.dart';
// import 'package:testflutter/reminder/widgets/coming_stuff.dart';
import 'package:flutterpma/reminder/util/dictionnary.dart' as dictionnary;
// import 'package:testflutter/reminder/database/db_handler.dart';
// import 'package:testflutter/reminder/database/settings_model.dart';

class HomePageExpert extends StatefulWidget {
  String email;
  var id;
  HomePageExpert({this.email,this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePageExpert> {
  static final url = 'http://'+url+':8000/api/blog';
  static final jsonplacholder = 'https://jsonplaceholder.typicode.com/posts';
  static final CREATE_POST_URL = 'http://'+url+':8000/api/auth/login';
  static final commentposturl = 'http://'+url+':8000/api/comment';
  String _selectedLang;
    final dbh = DatabaseHandler.internal();




  List data;
  var test;
  Future<String> getData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    this.setState(() {
      // test = jsonDecode(response.body);
      data = jsonDecode(response.body);
      test= jsonDecode(response.body);
    // print(test);

    });
    return "sccess";
  }
  

  @override
  void initState() {
    this.getData();
    print(widget.id);

    // print(widget.userinfo);

  }
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

  @override
  Widget build(BuildContext context) {
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
                // automaticallyImplyLeading: true,
                title: Text(widget.email),
                elevation: 13,
                actions: <Widget>[
                  Row(
                    children: <Widget>[
                  FlatButton(
             child: Icon(Icons.settings, color: Colors.white),
             onPressed: _showSettings,
           ),
                      // Text(widget.email,),
                      // IconButton(tooltip: widget.email,icon: Icon(Icons.ac_unit),padding: EdgeInsets.fromLTRB(0, 0, 50, 0),)
                    ],
                  )
                ],
              ),
              // ListTile(
              //   title: Text("Add resource"),
              //   trailing:Icon(Icons.add_comment),
              //   onTap: () {
              //     // Navigator.pushNamed(context, '/reminder');
              //       Navigator.push(
              //         context,
              //         new MaterialPageRoute(
              //           builder: (context) => ResourcePage(),
              //         ));
              //       // Navigator.push(
              //       // context,
              //       // MaterialPageRoute(
              //       //     builder: (context) => new MaterialApp(
              //       //           theme: ThemeData(primarySwatch: Colors.lightBlue),
              //       //           home: new Home(),
              //       //         )));
              //   },
              // ),
              ListTile(
                title: Text(
                  dictionnary.translate('chat')
                ),
                trailing: Icon(Icons.chat),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              // new WebViewContainer(),
                              ChatExpert(userid: widget.id,)));
                  // Navigator.pushNamed(context, '/chat');
                },
              ),
              // ListTile(
              //   title: Text("Reminder  \n አስታዋሽ"),
              //   trailing: Icon(Icons.alarm),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => new MaterialApp(
              //                   theme: ThemeData(primarySwatch: Colors.green),
              //                   home: new ComingStufWidget(),
              //                 )));
              //   },
              // ),
              // ListTile(
              //   title: Text("First Aid Kit "),
              //   trailing: Icon(Icons.local_hospital),
              //   onTap: () {},
              // ),

              ListTile(
                title: Text(
                dictionnary.translate('Add.blog')
                ),
                trailing: Icon(Icons.add_comment),
                // leading: ,
                onTap: () {
                  Navigator.push(
                        context,
                        new MaterialPageRoute(
                          
                          // builder: (context) => HomePageUser('user'),
                          builder: (context) =>UserOptions(email: widget.email,id: widget.id,)


                        ));
               
 
                },
              ),
              // Navigator.pop(context, Login());
              ListTile(
                title: Text( dictionnary.translate('Logout')),
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

        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data == null ? 0 : data.length,
                  // itemCount: data.length,
                  itemBuilder: _buildResource),
            )
          ],
        ));
  }

  Widget _buildResource(BuildContext context, int index) {
    
      TextEditingController userid = new TextEditingController();
    // TextEditingController blogid = new TextEditingController();
    // String userid = "1";
    String blogid = "1";
    TextEditingController text = new TextEditingController();
    TextEditingController comment = new TextEditingController();
    List<String> litems = [];
    final TextEditingController eCtrl = new TextEditingController();
   
    double c_width = MediaQuery.of(context).size.width * 0.8;
    double c_height = MediaQuery.of(context).size.height * 0.8;

    Color greencolor = Color(0xFF26C611DA);

    var now = DateTime.now();
    TextEditingController _controller = new TextEditingController();
    int maxLength = 55;

    return new Container(
        // margin: EdgeInsets.all(10),

        margin: EdgeInsets.fromLTRB(15, 50, 0, 15),
        height: 800,
        width: c_width,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Card(
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(13)),
            
              elevation: 25,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    // width: 400,
                    // child: Image.asset(data[index]['image'].toString()),

                    // child: Image.asset('assets/placeholder.jpg')
                    // child: Image.network(data[index]['img']),
                  child:  new FadeInImage(image: new NetworkImage(data[index]['image']), placeholder: new AssetImage('assets/hospital.jpg'))

                  ),
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
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),

                    child: Text(

                      // "time",
                      //  textAlign: TextAlign.left,
                      "posted " +
                          // data[index]['created_at'].toString() ,
                          // DateTime.now().timeZoneName.toString(),
                          // var now = DateTime.now();
                          DateTime.parse(data[index]['created_at'])
                              .toLocal()
                              .toString(),

                    ),
                  ),
                    Container(
                width: c_width,
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(child: 
                
                  GestureDetector(
                    child: Text("Link"),
                    onTap: () {
                      // Navigator.pushNamed(context, '/signupexpert');
                    },
                  ),
                      
                     ),
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
                      // TextFormField(controller:userid,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          color: greencolor,
                          onPressed: () async {
                            // getData();
                            Comment newPost = new Comment(
                                user_id: widget.id['user']['id'].toString(),
                                blog_id: test['user_id'],
                                text: comment.text);
                            Comment p = await createComment(commentposturl,
                                body: newPost.toMap());
                            // getData();ff
                            // getData();
                           

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
          ],
        ));
  }
}

void initLang() async {
  dictionnary.lang = 'en';
  final dbh = DatabaseHandler.internal();
  Settings settings = await dbh.readSettings();
  dictionnary.lang = (settings.lang == null) ? 'en' : settings.lang;
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
      // print(data.toString());
      // print( data['comments'].toString().startsWith('text'));
      // print(data['user']['role']);
      // print(response.body.contains(''));

      return Comment.fromJson(json.decode(response.body));
    });
  }