import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


final ThemeData iOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData defaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

// void main() {
//   runApp(FriendlyChatApp());
// }

// class FriendlyChatApp extends StatelessWidget {
  // String fullName;
  // FriendlyChatApp(this.fullName);
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "FriendlyChat",
//       home: ChatScreen(),
//       theme:
//           defaultTargetPlatform == TargetPlatform.iOS ? iOSTheme : defaultTheme,
//     );
//   }
// }

class ChatScreen extends StatefulWidget {
    String fullName;
  ChatScreen(this.fullName);
  @override
  State<StatefulWidget> createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  static final url = 'http://10.0.2.2:8000/api/users';
   List data;
   var datastring;


  var test;
  Future<String> getData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    this.setState(() {
      // test = jsonDecode(response.body);
      data = jsonDecode(response.body);
      datastring = data.toString();
    });
    print(data);
    print(datastring);

    

    return "sccess";
  }
  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatMessageRecieved> _messagesrecieved = <ChatMessageRecieved>[];

  final TextEditingController _textEditingController = TextEditingController();
  bool _isComposing = false;
  @override
  void initState() {
    super.initState();
    getData();
        Text(getData().toString());
  }
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(
        color: Theme.of(context).accentColor,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textEditingController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message " + widget.fullName),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? CupertinoButton(
                      child: Text("Send" ),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textEditingController.text)
                          : null,
                    )
                  : IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textEditingController.text)
                          : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textEditingController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
          duration: Duration(milliseconds: 320), vsync: this),fullName: "Dr" + " "+widget.fullName,

    );
     ChatMessageRecieved messagerecived = ChatMessageRecieved(
      text: datastring,
      animationController: AnimationController(
          duration: Duration(milliseconds: 320), vsync: this),fullName: data[1]['header'],

    );
    setState(() {
      _messages.insert(0, message);
      _messagesrecieved.insert(0, messagerecived);

    });
    message.animationController.forward();
    messagerecived.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Color greencolor = Color(0xFF26C6DA);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: greencolor,
        title: Text("Pma chat"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
           Flexible(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
              reverse: true,
              itemBuilder: (_, int index) => _messagesrecieved[index],
              itemCount: _messagesrecieved.length,
            ),
          ),
          
          Divider(
            height: 1.0,
          ),
          Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController,this.fullName});

  final String text;
  final AnimationController animationController;
final String fullName;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Text(text[0]),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    fullName ,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(text),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ChatMessageRecieved extends StatelessWidget {
    static final url = 'http://10.0.2.2:8000/api/blog';
   List data;


  var test;
  Future<String> getData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    // this.setState(() {
      // test = jsonDecode(response.body);
      data = jsonDecode(response.body);
    // });
    print(data);
    return "sccess";
  }
  ChatMessageRecieved({this.text, this.animationController,this.fullName});

  final String text;
  final AnimationController animationController;
final String fullName;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    fullName ,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(data.toString()),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 0.0),
              child: CircleAvatar(
                child: Text(text[0]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}