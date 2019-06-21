
import 'dart:convert';
import 'package:flutterpma/reminder/database/db_handler.dart';
import 'package:flutterpma/reminder/database/settings_model.dart';
import 'package:flutterpma/reminder/widgets/settings.dart';
import 'package:flutterpma/webview/youtube_webview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterpma/reminder/util/dictionnary.dart' as dictionnary;

import '../main.dart';


class FirstAidKit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FirstAidKitState();
  }
}

class FirstAidKitState extends State<FirstAidKit> {
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
    return ExpansionPanelList(
    
        children: [
          ExpansionPanel(
            headerBuilder: (context, isE) => Container(
                  child: Text(data[index]['disease']['name'][0].toString()),
                  alignment: Alignment.centerLeft,
                ),
            body: Container(
              color: Colors.blue[300],
              constraints: BoxConstraints.expand(height: 300),
              alignment: Alignment.center,
              child: 
              
              Column(children: <Widget>[
               Text (data[index]['disease']['name'],style: TextStyle(color: Colors.white,fontSize: 25),),
           
                ListTile(
                
              leading: Icon(Icons.arrow_right),
              title:Text(data[index]['symptom']),
            ),
           SizedBox(height: 5,),
            Center(child: Text('description',style: TextStyle(fontSize: 22,color: Colors.white),)),
            
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
                  Container(margin: EdgeInsets.fromLTRB(200, 0, 0, 0),child:     GestureDetector(
                          child: CircleAvatar(
              radius: 20,
              child: Image.asset('assets/youtube.png'),
            ),
                          onTap: () {
                             Navigator.push(
                        context,
                        new MaterialPageRoute(
                          
                          // builder: (context) => HomePageUser('user'),
                          builder: (context) =>Youtube(link: data[index]['video'].toString(),)


                        ));
                            //  return alert;
                            //  showDialog(context: context, builder: (BuildContext context) => alert);
                          },
                        ),)
            
             

                
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
            //  else {
            //   isB = !isE;
            // }
          });
        },
      );
  }

  static final experturl = 'http://'+url+':8000/api/firstAid';
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
        title: Text(dictionnary.translate('First.aid.kit')),
        backgroundColor:greencolor,
      ),
      body:  ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: _expan,
      )
    );
  }


}
