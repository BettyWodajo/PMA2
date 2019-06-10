// import 'package:flutter/material.dart';

// class BlogPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('New Resource '),
//         backgroundColor: Colors.greenAccent,
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.all(10),
//             child: new TextFormField(
//               style: TextStyle(color: Colors.blueAccent),
//               decoration: InputDecoration(
//                   hintStyle: TextStyle(color: Colors.red[200]),
//                   labelText: 'title'),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(10),
//             child: new TextFormField(
//               style: TextStyle(color: Colors.blueAccent),
//               decoration: InputDecoration(
//                   hintStyle: TextStyle(color: Colors.red[200]),
//                   labelText: 'Description'),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(10),
//             child: new TextFormField(
//               style: TextStyle(color: Colors.blueAccent),
//               decoration: InputDecoration(
//                   hintStyle: TextStyle(color: Colors.red[200]),
//                   labelText: 'Image'),
//             ),
//           ),
//           RaisedButton(
//             color: Colors.blueAccent,
//             child: Text(
//               "Add",
//             ),
//             onPressed: () {
//             Navigator.pop(context);
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PostBlog {
  final String header;
  final String image;
  final String content;
  final String userid;

  PostBlog({this.header, this.image, this.content, this.userid});

  factory PostBlog.fromJson(Map<String, dynamic> json) {
    return PostBlog(
      header: json['header'],
      image: json['header'],
      content: json['header'],
      userid: json['header'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['header'] = header;
    map["img"] = image;
    map['content'] = content;
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
    print(data);
    // print(data['user']['role']);
    // print(response.body.contains(''));

    return PostBlog.fromJson(json.decode(response.body));
  });
}

class UserOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UserOptionsState();
  }
}

class UserOptionsState extends State<UserOptions> {
  static final blogapi = 'http://10.0.2.2:8000/api/blog';
  TextEditingController header = new TextEditingController();
  TextEditingController image = new TextEditingController();
  TextEditingController content = new TextEditingController();
  TextEditingController userid = new TextEditingController();

//save the result of gallery file
  File galleryFile;

//save the result of camera file
  File cameraFile;

  @override
  Widget build(BuildContext context) {
    //display image selected from gallery
    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      print("You selected gallery image : " + galleryFile.path);
      setState(() {});
    }

    //display image selected from camera
    imageSelectorCamera() async {
      cameraFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        //maxHeight: 50.0,
        //maxWidth: 50.0,
      );
      print("You selected camera image : " + cameraFile.path);
      setState(() {});
    }

    return MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: new Text('Image Picker'),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new RaisedButton(
                child: new Text('Select Image from Gallery'),
                onPressed: imageSelectorGallery,
              ),
              new RaisedButton(
                child: new Text('Select Image from Camera'),
                onPressed: imageSelectorCamera,
              ),
              displaySelectedFile(galleryFile),
              displaySelectedFile(cameraFile),
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
                
              ),
              
              Container(
                padding: EdgeInsets.all(10),
                child: new TextFormField(
                  controller: userid,
                  style: TextStyle(color: Colors.blueAccent),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.red[200]),
                      labelText: 'user_id'),
                ),
              ),
              RaisedButton(
                color: Colors.blueAccent,
                child: Text('Add'),
                onPressed: () async {
                  PostBlog newPost = new PostBlog(
                    header: header.text,
                    image: image.text,
                    content: content.text,
                    userid: userid.text,
                  );
                  PostBlog p =
                      await createPostExpert(blogapi, body: newPost.toMap());
                },
              )
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
