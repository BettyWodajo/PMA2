import 'package:flutter/material.dart';
import 'package:flutterpma/expert/login.dart';
import 'package:flutterpma/reminder/database/db_handler.dart';
import 'package:flutterpma/reminder/database/settings_model.dart';
import 'package:flutterpma/reminder/widgets/coming_stuff.dart';
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

class HomePageExpert extends StatefulWidget {
  String email;
  HomePageExpert(this.email);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePageExpert> {
  static final url = 'http://10.0.2.2:8000/api/blog';
  static final jsonplacholder = 'https://jsonplaceholder.typicode.com/posts';
  static final CREATE_POST_URL = 'http://10.0.2.2:8000/api/auth/login';

  List data;
  var test;
  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json"});
    this.setState(() {
      // test = jsonDecode(response.body);
      data = jsonDecode(response.body);
    });
    // print(data);
    return "sccess";
  }

  @override
  void initState() {
    this.getData();
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
                automaticallyImplyLeading: false,
                title: Text(widget.email),
                elevation: 13,
                actions: <Widget>[
                Row(children: <Widget>[
                    IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                    // alignment: Alignment.topLeft,
                    icon: Icon(
                      Icons.account_circle,
                      size: 45,
                    ),
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                  ),
                  // Text(widget.email,),
                  // IconButton(tooltip: widget.email,icon: Icon(Icons.ac_unit),padding: EdgeInsets.fromLTRB(0, 0, 50, 0),)
                ],)
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
                title: Text("Chat "),
                trailing: Icon(Icons.chat),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              // new WebViewContainer(),
                              Container()));
                },
              ),
              ListTile(
                title: Text("Reminder "),
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
              // ListTile(
              //   title: Text("First Aid Kit "),
              //   trailing: Icon(Icons.local_hospital),
              //   onTap: () {},
              // ),
             
              ListTile(
                title: Text("Add blog"),
                trailing: Icon(Icons.add_comment),
                onTap: () {
                  Navigator.pushNamed(context, '/blog');
                },
              ),
              // Navigator.pop(context, Login());
              ListTile(
                title: Text("Logout"),
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
    String dummy = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';

    double c_width = MediaQuery.of(context).size.width * 0.8;
    double c_height = MediaQuery.of(context).size.height * 0.8;

    
    Color greencolor = Color(0xFF26C6DA);

    var now = DateTime.now();
    TextEditingController _controller = new TextEditingController();
    int maxLength = 55;

    return new Container(
        // margin: EdgeInsets.all(10),

        margin: EdgeInsets.fromLTRB(15, 50, 0, 15),
        height: 700,
        width: c_width,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 25,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    // width: 400,
                    child: Image.asset('assets/placeholder.jpg')
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                    child: Text(
                      // 'test',
                      data[index]['header'],
                      style: TextStyle(fontSize: 25, color: greencolor),
                    ),
                  ),
                  SizedBox(height: 2,),
                      Container(
                    width:c_width ,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      data[index]['content'],
                      // dummy,
                     textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),),
                         Container(
                    padding:EdgeInsets.symmetric(horizontal: 5),
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
                  )
                ],
              ),
            ),
          ],
//       child: Card(
//         // color: Colors.greenAccent,
//           elevation: 10,
//           shape: BeveledRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           // margin: EdgeInsets.all(10),
//           child: Column(
//             // scrollDirection: Axis.horizontal,
//             children: <Widget>[

// //                 child: SizedBox(
// //                     height: 200,
// //                     width: 300,
// //                     // child: Image.asset(data[index]['image'].toString()),
// // //               child: Image.network(
// // //   data[index]['image'],
// // ),
// //                     child: Image.network(
// //                       'https://picsum.photos/id/322/200/300',
// //                     )

// //                     // height: 200,
// //                     // width: 400,
// //                     ),
// //               ),
//               SizedBox(
//                 height: 5,
//               ),

//               Row(
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
          // Container(
          //   padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
          //   child: Text('test',
          //     // data[index]['title'],
          //     style: TextStyle(fontSize: 25, color:greencolor),
          //   ),
//                   ),
//                 ],
//               ),

//               Column(
//                 children: <Widget>[
//                   Container(
//                     width:c_width ,
//                     // padding: EdgeInsets.symmetric(horizontal: 5),
//                     margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                     child: Text(
//                       // data[index]['description'],
//                       'asdklfjkasdkfjladsflkjadslkfjklasdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
//                      textAlign: TextAlign.left,
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                       ),
//                     ),
// //                   child: new TextField(
// //     controller: _controller,
// //     onChanged: (String newVal) {
// //         if(newVal.length <= maxLength){
// //             text = newVal;
// //         }else{
// //             _controller.text = text;
// //         }

// //     }
// // ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(15),
//                     child: Text(
//                       "time",
//                       // "posted " +
//                       //     // data[index]['created_at'].toString() ,
//                       //     // DateTime.now().timeZoneName.toString(),
//                       //     DateTime.parse(data[index]['created_at'])
//                       //         .toLocal()
//                       //         .toString(),
//                       style: TextStyle(
//                         fontSize: 10,
//                         color: Colors.black,
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           )),
        ));
  }
}

void initLang() async {
  dictionnary.lang = 'en';
  final dbh = DatabaseHandler.internal();
  Settings settings = await dbh.readSettings();
  dictionnary.lang = (settings.lang == null) ? 'en' : settings.lang;
}
