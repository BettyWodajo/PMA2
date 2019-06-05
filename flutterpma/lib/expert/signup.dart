import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterpma/expert/expert_signup_model.dart';
import 'package:flutterpma/expert/home.dart';
import 'package:flutterpma/user/customer_signup_model.dart';
import 'package:flutterpma/user/homeuser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<PostCustomer> createPost(String url, {Map body}) async {
  var data;

  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    data = jsonDecode(response.body);
    //save the access toke everytime
    print(data);
    // print(data['user']['role']);
    // print(response.body.contains(''));

    return PostCustomer.fromJson(json.decode(response.body));
  });
}

Future<PostExpert> createPostExpert(String url, {Map body}) async {
  var data;

  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    data = jsonDecode(response.body);
    //save the access toke everytime
    print(data);
    // print(data['user']['role']);
    // print(response.body.contains(''));

    return PostExpert.fromJson(json.decode(response.body));
  });
}

class Signup extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<Signup> {
  static final signup = 'http://10.0.2.2:8000/api/register';
  static final checkuser = 'http://10.0.2.2:8000/api/users';

  TextEditingController fullnamec = new TextEditingController();
  TextEditingController emailc = new TextEditingController();
  TextEditingController rolec = new TextEditingController();
  TextEditingController addressc = new TextEditingController();
  TextEditingController diseaseidc = new TextEditingController();
  TextEditingController passwordc = new TextEditingController();

  TextEditingController fullnamee = new TextEditingController();
  TextEditingController emaile = new TextEditingController();
  TextEditingController rolee = new TextEditingController();
  TextEditingController addresse = new TextEditingController();
  TextEditingController joblocatione = new TextEditingController();
  TextEditingController specializatione = new TextEditingController();
  TextEditingController diseaseide = new TextEditingController();

  TextEditingController passworde = new TextEditingController();
  String customer = "customer";
  String expert = "expert";

  // String customer = "customer";

  var data;
  var test;
  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull(checkuser),
        headers: {"Accept": "application/json"});
    this.setState(() {
      // test = jsonDecode(response.body);
      data = jsonEncode(response.body);
      // print(data.contains('expert'));
    });
    print(data);
    return "sccess";
  }

  @override
  void initState() {
    this.getData();
  }

  bool visibilityTag = false;
  bool visibilityObs = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag") {
        visibilityTag = visibility;
      }
      if (field == "obs") {
        visibilityObs = visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: new AppBar(backgroundColor: new Color(0xFF26C6DA)),
        body: new ListView(
      padding: EdgeInsets.fromLTRB(0, 55, 0, 0),
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.all(20.0),
          child: CircleAvatar(
            radius: 55,
            child: Image.asset('assets/hospital.jpg'),
            // backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
          ),
        ),
        new Container(
          margin: new EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        new Container(
            margin: new EdgeInsets.only(left: 16.0, right: 16.0),
            child: new Column(
              children: <Widget>[
                visibilityObs
                    ? new Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new Expanded(
                              flex: 11,
                              child: Column(
                                children: <Widget>[
                                  new TextField(
                                    controller: fullnamec,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                        labelText: "Full name ", isDense: true),
                                  ),
                                  new TextField(
                                    controller: emailc,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                        labelText: "Email", isDense: true),
                                  ),
                                  // new TextField(
                                  //   controller: rolec,
                                  //   maxLines: 1,
                                  //   style: Theme.of(context).textTheme.title,
                                  //   decoration: new InputDecoration(
                                  //     labelText: "role",
                                  //     isDense: true,
                                  //   ),
                                  // ),

                                  // new DropdownButton<String>(
                                  //   items: <String>['customer', 'expert']
                                  //       .map((String value) {
                                  //     return new DropdownMenuItem<String>(
                                  //       value: value,
                                  //       child: new Text(value),
                                  //     );
                                  //   }).toList(),
                                  //   onChanged: (_) {},
                                  // ),
                                  new TextField(
                                    controller: addressc,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                      labelText: "address",
                                      isDense: true,
                                    ),
                                  ),
                                  new TextField(
                                    controller: diseaseidc,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                      labelText: "diseaseid",
                                      isDense: true,
                                    ),
                                  ),
                                  new TextField(
                                    controller: passwordc,
                                    obscureText: true,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                      labelText: "password",
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: RaisedButton(
                                      color: Colors.greenAccent,
                                      onPressed: () async {
                                        PostCustomer newPost = new PostCustomer(
                                          fullname: fullnamec.text,
                                          email: emailc.text,
                                          address: addressc.text,
                                          role: customer,
                                          diseaseid: diseaseidc.text,
                                          password: passwordc.text,
                                        );
                                        PostCustomer p = await createPost(
                                                signup,
                                                body: newPost.toMap())
                                            .then((_) => newPost)
                                            .catchError((e) {
                                          print(newPost
                                              .fullname); // Finally, callback fires.
                                        }) // Future completes with 42.
                                            .then((value) {
                                          if (data.contains(newPost.email)) {
                                            // print(data.contains(newPost.email+ ''));
                                            print(data.contains(newPost.email));
                                            print(customer);

                                            Fluttertoast.showToast(
                                                msg: newPost.email +
                                                    " Invalid input",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIos: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                          // else if (data.contains('expert')){
                                          //   print(data.contains('expert'));
                                          //     Fluttertoast.showToast(
                                          //   msg: "Welcome"+newPost.fullname ,
                                          //   toastLength: Toast.LENGTH_SHORT,
                                          //   gravity: ToastGravity.BOTTOM,
                                          //   timeInSecForIos: 1,
                                          //   backgroundColor: Colors.greenAccent,
                                          //   textColor: Colors.white,
                                          //   fontSize: 16.0);
                                          //     Navigator.push(
                                          // context,
                                          // new MaterialPageRoute(
                                          //   // builder: (context) => HomePageExpert(newPost.email),
                                          //   // builder: (context) => HomePageUser('user'),
                                          //   builder: (context) => HomePageExpert(newPost.email),
                                          // ));
                                          // }
                                          //
                                          else {
                                            Fluttertoast.showToast(
                                                msg: "Welcome" +
                                                    newPost.fullname,
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIos: 1,
                                                backgroundColor:
                                                    Colors.greenAccent,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    // builder: (context) => HomePageExpert(newPost.email),
                                                    // builder: (context) => HomePageUser('user'),
                                                    builder: (context) =>
                                                        HomePageUser(
                                                           email: newPost.email)));
                                          }
                                          ;

                                          // print(data);
                                        });
                                      },
                                      child: Text(' sign up'),
                                    ),
                                  ),
                                ],
                              )),
                          new Expanded(
                            flex: 1,
                            child: new IconButton(
                              color: Colors.grey[400],
                              icon: const Icon(
                                Icons.cancel,
                                size: 22.0,
                              ),
                              onPressed: () {
                                _changed(false, "obs");
                              },
                            ),
                          ),
                        ],
                      )
                    : new Container(),
                visibilityTag
                    ? new Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new Expanded(
                              flex: 11,
                              child: Column(
                                children: <Widget>[
                                  new TextField(
                                    controller: fullnamee,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                        labelText: "Full name", isDense: true),
                                  ),
                                  new TextField(
                                    controller: emaile,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                        labelText: "Email", isDense: true),
                                  ),
                                  // new TextField(
                                  //   controller: rolee,
                                  //   maxLines: 1,
                                  //   style: Theme.of(context).textTheme.title,
                                  //   decoration: new InputDecoration(
                                  //       labelText: "role", isDense: true),
                                  // ),
                              //  Container(margin: EdgeInsets.fromLTRB(20, 0, 0, 0),child:    new DropdownButton<String>(
                              //       items: <String>['customer', 'expert']
                              //           .map((String value) {
                              //         return new DropdownMenuItem<String>(
                              //           value: value,
                              //           child: new Text(value),
                              //         );
                              //       }).toList(),
                              //       onChanged: (_) {},
                              //     ),),
                                  new TextField(
                                    controller: addresse,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                        labelText: "Address", isDense: true),
                                  ),
                                  new TextField(
                                    controller: joblocatione,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                        labelText: "Job location",
                                        isDense: true),
                                  ),
                                  new TextField(
                                    controller: specializatione,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                        labelText: "Specialization",
                                        isDense: true),
                                  ),
                                  new TextField(
                                    keyboardType: TextInputType.number,
                                    controller: diseaseide,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                      labelText: "disease id ",
                                      isDense: true,
                                    ),
                                  ),
                                  new TextField(
                                    controller: passworde,
                                    obscureText: true,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title,
                                    decoration: new InputDecoration(
                                      labelText: "password",
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RaisedButton(
                                    color: Colors.greenAccent,
                                    onPressed: () async {
                                      PostExpert newPost = new PostExpert(
                                        fullname: fullnamee.text,
                                        email: emaile.text,
                                        role: expert,
                                        address: addresse.text,
                                        joblocation: joblocatione.text,
                                        specialization: specializatione.text,
                                        diseaseid: diseaseide.text,
                                        password: passworde.text,
                                      );
                                      PostExpert p = await createPostExpert(
                                              signup,
                                              body: newPost.toMap())
                                          .then((_) => newPost)
                                          .catchError((e) {
                                        print(newPost
                                            .fullname); // Finally, callback fires.
                                      }) // Future completes with 42.
                                          .then((value) {
                                        if (data.contains(newPost.email)) {
                                          // print(data.contains(newPost.email+ ''));
                                          print(data.contains(newPost.email));

                                          Fluttertoast.showToast(
                                              msg: newPost.email +
                                                  " Invalid input",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIos: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                        // else if (data.contains('expert')){
                                        //   print(data.contains('expert'));
                                        //     Fluttertoast.showToast(
                                        //   msg: "Welcome"+newPost.fullname ,
                                        //   toastLength: Toast.LENGTH_SHORT,
                                        //   gravity: ToastGravity.BOTTOM,
                                        //   timeInSecForIos: 1,
                                        //   backgroundColor: Colors.greenAccent,
                                        //   textColor: Colors.white,
                                        //   fontSize: 16.0);
                                        //     Navigator.push(
                                        // context,
                                        // new MaterialPageRoute(
                                        //   // builder: (context) => HomePageExpert(newPost.email),
                                        //   // builder: (context) => HomePageUser('user'),
                                        //   builder: (context) => HomePageExpert(newPost.email),
                                        // ));
                                        // }
                                        //
                                        else {
                                          print(data);
                                          Fluttertoast.showToast(
                                              msg: "Welcome" +
                                                  "  " +
                                                  "DR " +
                                                  " " +
                                                  newPost.fullname,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIos: 1,
                                              backgroundColor:
                                                  Colors.greenAccent,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  // builder: (context) => HomePageExpert(newPost.email),
                                                  // builder: (context) => HomePageUser('user'),
                                                  builder: (context) =>
                                                      HomePageExpert(
                                                          email:newPost.email)));
                                        }
                                        ;

                                        // print(data);
                                      });
                                    },
                                    child: Text(' sign up'),
                                  ),
                                ],
                              )),
                          new Expanded(
                            flex: 1,
                            child: new IconButton(
                              color: Colors.grey[400],
                              icon: const Icon(
                                Icons.cancel,
                                size: 22.0,
                              ),
                              onPressed: () {
                                _changed(false, "tag");
                              },
                            ),
                          ),
                        ],
                      )
                    : new Container(),
              ],
            )),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new InkWell(
                onTap: () {
                  visibilityObs ? null : _changed(true, "obs");
                },
                child: new Container(
                  margin: new EdgeInsets.only(top: 16.0),
                  child: new Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        child: Image.asset('assets/patient.png'),
                      ),
                      new Icon(Icons.add,
                          color: visibilityObs
                              ? Colors.grey[400]
                              : Colors.grey[600]),
                      new Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: new Text(
                          "User",
                          style: new TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: visibilityObs
                                ? Colors.grey[400]
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            new SizedBox(width: 24.0),
            new InkWell(
                onTap: () {
                  visibilityTag ? null : _changed(true, "tag");
                },
                child: new Container(
                  margin: new EdgeInsets.only(top: 16.0),
                  child: new Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        child: Image.asset('assets/doctor.png'),
                      ),
                      new Icon(Icons.add,
                          color: visibilityTag
                              ? Colors.grey[400]
                              : Colors.grey[600]),
                      new Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: new Text(
                          "Expert",
                          style: new TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: visibilityTag
                                ? Colors.grey[400]
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }
}
