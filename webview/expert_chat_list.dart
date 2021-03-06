import 'dart:async';
import 'package:flutter/material.dart';
import "package:flutter_webview_plugin/flutter_webview_plugin.dart";

class ChatExpert extends StatefulWidget {
var userid;
ChatExpert({this.userid});

  @override
  ChatExpertState createState() => ChatExpertState();
}

class ChatExpertState extends State<ChatExpert> {
  @override
  Widget build(BuildContext context) {
    Color greencolor = Color(0xFF26C6DA);

    // final flutterWebviewPlugin = new FlutterWebviewPlugin();

 // var data =userid;
    // TODO: implement build
    return Container(
              height: 150,
            // margin: EdgeInsets.fromLTRB(0, 55, 0, 0),
         
              child: Column(
                children: <Widget>[
                Expanded(child: 
                  WebviewScaffold(
                    // appBar: AppBar(title: Text('chat'),automaticallyImplyLeading: true,),
                    url: 'http://10.0.2.2:8000/messages/${widget.userid}',
                    withJavascript: true,
                    appBar: new AppBar(
                      backgroundColor: greencolor,
                      title: const Text("Pma chat"),
                    ),
                    // withZoom: true,
                      // clearCache: true,
                      // withLocalUrl: true,
                    resizeToAvoidBottomInset: true,
                    // allowFileURLs: true,
                    // withLocalStorage: true,
                    hidden: true,
                    initialChild: Container(
                      color: Colors.white,
                      child:const Center(
                        child: CircularProgressIndicator(backgroundColor: Colors.white),
                      ),
                    ),
                  ),)
                ],
              ),
            );
        // },
        // );
  }
}
