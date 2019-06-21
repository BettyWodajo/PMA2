import 'dart:convert';
import 'package:flutterpma/reminder/database/db_handler.dart';
import 'package:flutterpma/reminder/database/settings_model.dart';
import 'package:flutterpma/reminder/widgets/settings.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../main.dart';
import '../reminder/util/dictionnary.dart' as dictionnary;


class MedicalLibrary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MedicalLibraryState();
  }
}

class MedicalLibraryState extends State<MedicalLibrary> {
  var isA = false;
  var isB = true;
  
    String _selectedLang;
    final dbh = DatabaseHandler.internal();
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

  Widget _expan(BuildContext context, int index) {
    List description =  json.decode(data[index]['description']
            );
   return  ExpansionPanelList(
        children: [
          ExpansionPanel(
            headerBuilder: (context, isE) => Container(
                  child: Text(data[index]['name'].toString()[0],style: TextStyle(fontSize:22),),
                  alignment: Alignment.centerLeft,
                ),
            body: Container(
              color: Colors.greenAccent,
              constraints: BoxConstraints.expand(height: 300),
              alignment: Alignment.center,
              child: 
              
              Column(children: <Widget>[
                 Text(data[index]['name'],style: TextStyle(fontSize:22)),
           
                ListTile(
                
              leading: Icon(Icons.arrow_right),
              title:Text(data[index]['symptom'],style: TextStyle(fontStyle:FontStyle.italic)),
            ),
            SizedBox(height: 5,),
            Center(child: Text('description',style: TextStyle(fontSize: 22),)),
            
             ListTile(
              leading: Icon(Icons.arrow_right),
              title: 
              Text(description[0]['name'],style: TextStyle(fontStyle:FontStyle.italic) ),
              ),
               ListTile(
              leading: Icon(Icons.arrow_right),
              title: 
              Text(description[1]['name'] ,style: TextStyle(fontStyle:FontStyle.italic)),
              ),
            GestureDetector(child: 
                  Text("Video"),
                  onTap: () {
                      Navigator.pushNamed(context, '/youtube');
                    },

            )
              
           
            
             

                
              ],)
              
            ),
            isExpanded: isA,
          ),
          // ExpansionPanel(
          //   headerBuilder: (context, isE) => Container(
          //         child: Text(data[index]['name'].toString()[0]),
          //         alignment: Alignment.centerLeft,
          //       ),
          //   body: Container(
          //     color: Colors.blueAccent,
          //     constraints: BoxConstraints.expand(height: 100),
          //     alignment: Alignment.center,
          //     child: Text(data[index]['name']),
          //   ),
          //   isExpanded: isB,
          // ),
        ],
        expansionCallback: (index, isE) {
          print("index: $index, isE: $isE");
          setState(() {
            if (index == 0) {
              isA = !isE;
            } 
            // else {
            //   isB = !isE;
            // }
          });
        },
      );
      }
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

  static final experturl = 'http://'+url+':8000/api/diseases';
  List data;
  List test;
  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull(experturl),
        headers: {"Accept": "application/json"});
    this.setState(() {
      // test = jsonDecode(response.body); data[index]['description']
      data = jsonDecode(response.body);
      test = jsonDecode(data[1]['description']); 
    });
    print(test[0]['name']);
    // print(test);

    
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
        title: Text(dictionnary.translate('Medical.library')),
        backgroundColor:greencolor,
      ),
      body:  ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: _expan,
      )
    );
  }

  Widget _buildResource(BuildContext context, int index) {
    final int value = 1;

    Color greencolor = Color(0xFF26C6DA);

    return 
        Column(
          children: <Widget>[
            Card(
              color: greencolor,
              margin: EdgeInsets.all(10),
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
                      style: TextStyle(fontSize: 55, color: Colors.redAccent),
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
              leading: Icon(Icons.arrow_right),
              title: Text(json.decode(data[index]['description']),strutStyle:StrutStyle(fontSize: 14) 
            )),
           
        //   ],
        // ),
                  // SizedBox(width: 5,),
                
                ],
              ),
            ),
          ],
        );
  }
}
