import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MedicalLibrary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MedicalLibraryState();
  }
}

class MedicalLibraryState extends State<MedicalLibrary> {
//  final int value;
//   final Widget filledStar;
//   final Widget unfilledStar;

  // const StarDisplayWidget({
  //   Key key,
  //   this.value = 0,
  //   @required this.filledStar,
  //   @required this.unfilledStar,
  // })  : assert(value != null),
  //       super(key: key);

  static final experturl = 'http://10.0.2.2:8000/api/diseases';
  List data;
  var test;
  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull(experturl),
        headers: {"Accept": "application/json"});
    this.setState(() {
      // test = jsonDecode(response.body);
      data = jsonDecode(response.body);
    });
    print(data);
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

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Library'),
        backgroundColor:greencolor,
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: _buildResource,
      ),
    );
  }

  Widget _buildResource(BuildContext context, int index) {
    final int value = 1;

    Color greencolor = Color(0xFF26C6DA);

    return new Container(
        height: 300,
        width: 300,
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // SizedBox(
                  //     width: 500, child: Image.asset('assets/placeholder.jpg')),
                  Container(
                    width: 500,
                    padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                    child: Text(
                      // 'Dr Abebe',
                      data[index]['name'],
                      style: TextStyle(fontSize: 55, color: greencolor),
                    ),
                  ),
          
              ListTile(
                
              leading: Icon(Icons.arrow_right),
              title:Text(data[index]['symptom']),
            ),
                 
                
          //          ListView(
          //           //  scrollDirection: Axis.vertical,
          // children: <Widget>[
          
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text(data[index]['description'],
            )),
           
        //   ],
        // ),
                  // SizedBox(width: 5,),
                
                ],
              ),
            ),
          ],
        ));
  }
}
