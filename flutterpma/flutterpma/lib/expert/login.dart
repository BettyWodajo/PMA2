import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterpma/expert/home.dart';
import 'package:flutterpma/expert/signup.dart';
import 'package:flutterpma/user/homeuser.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';



class Post {
  final String email;
  final String password;

  Post({this.email, this.password});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      email: json['email'],
      password: json['password'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["password"] = password;
    // map["body"] = body;

    return map;
  }
}

Future<Post> createPost(String url, {Map body}) async {
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

    return Post.fromJson(json.decode(response.body));
  });
}


class Login extends StatelessWidget {
    var data;
  Future<Post> createPost(String url, {Map body}) async {


  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    data = jsonDecode(response.body);
    //save the access toke everytime
    // print(data);
    print(data['user']['role']);
    // print(response.body.contains(''));

    return Post.fromJson(json.decode(response.body));
  });
}

    static final LOGINURL = 'http://10.0.2.2:8000/api/auth/login';
static final role = 'http://10.0.2.2:8000/api/user/expert';
  // var data ;
  // Future<String> getData() async {

  //   var response = await http.get(Uri.encodeFull(role),
  //       headers: {"Accept": "application/json"});
  //     // test = jsonDecode(response.body);
  //     data = jsonDecode(response.body);
  //   print(data.toString().contains('role'));  

  //   print(data);
  //   return "sccess";
  // }


  TextEditingController emailcontroler = new TextEditingController();
  TextEditingController passwordcontroler = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool _acceptterms = false;

    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.all(20.0),
            child: CircleAvatar(
              radius: 55,
              child: Image.asset('assets/hospital.jpg'),
            ),
          ),
            new Container(
            margin: new EdgeInsets.all(20.0),
              child: Center(child: Text('Sign in',style: TextStyle(fontSize: 30),),),
          ),
          Container(
            margin: new EdgeInsets.only(left: 50.0, right: 50.0),
            child: Column(
              children: <Widget>[
                new TextField(
                  controller: emailcontroler,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.title,
                  decoration: new InputDecoration(
                    labelText: "Email",
                    // isDense: true
                  ),
                ),
                new TextField(
                                obscureText: true,

                  controller: passwordcontroler,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.title,
                  decoration: new InputDecoration(
                    labelText: "password",
                    
                    // isDense: true
                  ),
                ),
                SwitchListTile(
                    onChanged: (bool value) {
                      _acceptterms = value;
                    },
                    value: _acceptterms,
                    title: Text("Accept Terms of PMA")),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: RaisedButton(
                    color: Colors.greenAccent,
               onPressed: () async {
                Post newPost = new Post(
                  email: emailcontroler.text,
                  password: passwordcontroler.text,
                );
                Post p =
                    await createPost(LOGINURL, body: newPost.toMap())
                        .then((_) => newPost)
                        .catchError((e) {
                  print(e); // Finally, callback fires.
                  return Fluttertoast.showToast(
                      msg: "Incorrect email or password",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0); // Future completes with 42.
                }).then((value) {
                  print(data);
                  
                  if (data['user']['role']=='expert') {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          // builder: (context) => HomePageExpert(newPost.email),
                          // builder: (context) => HomePageUser('user'),
                          builder: (context) => HomePageExpert(newPost.email),


                        ));
                  } else {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          // builder: (context) => HomePageUser('user'),
                          builder: (context) => HomePageUser(newPost.email),


                        ));
                  }
                  ;
                });
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //       builder: (context) => HomePage("Expert"),
                      //     ));
                    },
                    textTheme: ButtonTextTheme.primary,
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                new Container(
                  child: GestureDetector(
                    child: Text("Not a memeber Sign up"),
                    onTap: () {
                      Navigator.pushNamed(context, '/signupexpert');
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
