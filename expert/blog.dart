

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterpma/expert/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class PostBlog {
  final String header;
  final String image;
  final String body;
  final String userid;

  PostBlog({this.header, this.image, this.body, this.userid});

  factory PostBlog.fromJson(Map<String, dynamic> json) {
    return PostBlog(
      header: json['header'],
      image: json['image'],
      body: json['body'],
      userid: json['user_id'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['header'] = header;
    map["image"] = image;
    map['body'] = body;
    map['user_id'] = userid;

    // map["body"] = body;

    return map;
  }
}

Future<PostBlog> createPostExpert(String url, {Map body}) async {
  var data;

  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    data = jsonDecode(response.body);
    //save the access toke everytime
    // print(data);
    // print(data['user']['role']);
    // print(response.body.contains(''));

    return PostBlog.fromJson(json.decode(response.body));
  });
}


class UserOptions extends StatefulWidget {
  String email;
  var id;
  UserOptions({this.email,this.id});
  @override
  State<StatefulWidget> createState() {
    return new UserOptionsState();
  }
}

class UserOptionsState extends State<UserOptions> {
  static final url = 'http://'+url+':8000/api/users';

    List data;
  var userinfo;
  Future<String> getData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    this.setState(() {
      // test = jsonDecode(response.body);
      data = jsonDecode(response.body);
      // test = jsonDecode(response.body);
      print( widget.id);
      // test = jsonEncode(data[0]['comments']);
    });
    // print(data[4]['id'] );
    // print( data[1]['comments']);
    // print( test.toString().matchAsPrefix('idff'));

    return "sccess";
  }
  static final blogapi = 'http://'+url+':8000/api/blog';
  TextEditingController header = new TextEditingController();
  TextEditingController image = new TextEditingController();
  TextEditingController content = new TextEditingController();
  TextEditingController userid = new TextEditingController();
  TextEditingController link = new TextEditingController();


//save the result of gallery file
  File galleryFile;

//save the result of camera file
  File cameraFile;

  @override
  Widget build(BuildContext context) {
    //display image selected from gallery
    // imageSelectorGallery() async {
    //   galleryFile = await ImagePicker.pickImage(
    //     source: ImageSource.gallery,
    //     // maxHeight: 50.0,
    //     // maxWidth: 50.0,
    //   );
    //   print("You selected gallery image : " + galleryFile.path);
    //   setState(() {});
    // }

    //display image selected from camera
    // imageSelectorCamera() async {
    //   cameraFile = await ImagePicker.pickImage(
    //     source: ImageSource.camera,
    //     //maxHeight: 50.0,
    //     //maxWidth: 50.0,
    //   );
    //   print("You selected camera image : " + cameraFile.path);
    //   setState(() {});
    // }
    Color greencolor = Color(0xFF26C6DA);

    return MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        title: new Text('Add Blog'),
        backgroundColor: greencolor,
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new ListView(
            padding: EdgeInsets.all(10),
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // new RaisedButton(
              //   child: new Text('Select Image from Gallery'),
              //   onPressed: imageSelectorGallery,
              // ),
              // new RaisedButton(
              //   child: new Text('Select Image from Camera'),
              //   onPressed: imageSelectorCamera,
              // ),
              // displaySelectedFile(galleryFile),
              // displaySelectedFile(cameraFile),
              Container(
                padding: EdgeInsets.all(10),
                child: new TextFormField(
                  controller: header,
                  style: TextStyle(color: Colors.blueAccent),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.red[200]),
                      labelText: 'header'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: new TextFormField(
                  controller: content,
                  style: TextStyle(color: Colors.blueAccent),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.red[200]),
                      labelText: 'Content'),
                ),
                
              ),
               Container(
                padding: EdgeInsets.all(10),
                child: new TextFormField(
                  controller: image,
                  style: TextStyle(color: Colors.blueAccent),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.red[200]),
                      labelText: 'image'),
                ),
                // child: RaisedButton(child: Text('image'),onPressed: (){
                //   cameraFile;
                // },),
                
              ),
              //   Container(
              //   padding: EdgeInsets.all(10),
              //   child: new TextFormField(
              //     controller: link,
              //     style: TextStyle(color: Colors.blueAccent),
              //     decoration: InputDecoration(
              //         hintStyle: TextStyle(color: Colors.red[200]),
              //         labelText: 'Link'),
              //   ),
              //   // child: RaisedButton(child: Text('image'),onPressed: (){
              //   //   cameraFile;
              //   // },),
                
              // ),
              
              // Container(
              //   padding: EdgeInsets.all(10),
              //   child: new TextFormField(
              //     controller: userid,
              //     style: TextStyle(color: Colors.blueAccent),
              //     decoration: InputDecoration(
              //         hintStyle: TextStyle(color: Colors.red[200]),
              //         labelText: 'user_id'),
              //   ),
              // ),
            Center(child:   RaisedButton(
                // padding: EdgeInsets.all(15),
                
                
                color: Colors.greenAccent,
                child: Text('Add'),
                onPressed: () async {
                  // getData();
                  // test = widget.userid;
                  // userinfo = widget.id;
                  // print(widget.userinfo['user']['id']);


                  // print(userinfo['user']['id']);
                  PostBlog newPost = new PostBlog(
                    header: header.text,
                    image: image.text,
                    body: content.text,
                    userid: widget.id.toString(),
                    
                  );
                  PostBlog p =
                      await createPostExpert(blogapi, body: newPost.toMap())
                      .then((_) => newPost)
                      .catchError((e)
                      {
                          print(e); // Finally, callback fires.
                  return Fluttertoast.showToast(
                      msg: "Fill All the forms",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                      }).then((onValue){
                        if(newPost.header==null || image==null){

    Fluttertoast.showToast(
                      msg: "forms cant be empty",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                        }else{
                              Navigator.push(
                        context,
                        new MaterialPageRoute(
                          // builder: (context) => HomePageExpert(newPost.email),
                          // builder: (context) => HomePageUser('user'),
                          builder: (context) => HomePageExpert(email:widget.email,id: widget.id,),


                        ));

                        }

                      });
                },
              ),)
            ],
          );
        },
      ),
    ));
  }

  Widget displaySelectedFile(File file) {
    return new SizedBox(
      height: 200.0,
      width: 300.0,
//child: new Card(child: new Text(''+galleryFile.toString())),
//child: new Image.file(galleryFile),
      child: file == null
          ? new Text('Sorry nothing selected!!')
          : new Image.file(file),
    );
  }
}
