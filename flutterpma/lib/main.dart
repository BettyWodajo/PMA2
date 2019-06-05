import "package:flutter/material.dart";
import 'package:flutterpma/expert/blog.dart';
import 'package:flutterpma/expert/chat.dart';
import 'package:flutterpma/expert/home.dart';
import 'package:flutterpma/user/expert.dart';
import 'package:flutterpma/user/first_aid_kit.dart';
import 'package:flutterpma/user/medical_library.dart';

import 'expert/login.dart';
import 'expert/signup.dart';

void main() {
  runApp(new ControlleApp());
  initLang();
}

class ControlleApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // darkTheme: ThemeData.dark(),
      routes: {
            '/signupexpert': (BuildContext context) => Signup(),
            '/loginexpert': (BuildContext context) => Login(),
            '/expert': (BuildContext context) => Expertpage(),
            '/medicallibrary': (BuildContext context) => MedicalLibrary(),
            '/firstaidkit': (BuildContext context) => FirstAidKit(),
            // '/chat' :   (BuildContext context) => FriendlyChatApp(),



            

            
            
      },
      title: "PMA",
      home: new Login(),
    );
  }
}
