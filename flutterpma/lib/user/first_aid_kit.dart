// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class FirstAidKit extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return FirstAidKitState();
//   }
// }
// class FirstAidKitState extends State<FirstAidKit>{
  // static final url = 'http://10.0.2.2:8000/api/firstAid';

  //   List data;
  // var test;
  // Future<String> getData() async {
  //   var response = await http.get(Uri.encodeFull(url),
  //       headers: {"Accept": "application/json"});
  //   this.setState(() {
  //     // test = jsonDecode(response.body);
  //     data = jsonDecode(response.body);
  //   });
  //   print(data);
  //   return "sccess";
  // }

  // @override
  // void initState() {
  //   this.getData();
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Carousel in vertical scrollable'),
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.symmetric(vertical: 16.0),
//         itemBuilder: (BuildContext context, int index) {
//           // if(index % 2 == 0) {
//             return _buildCarousel(context, index ~/ 2);
//           // }
//           // else {
//           //   return Divider();
//           // }
//         },
//       ),
//     );
//   }

//   Widget _buildCarousel(BuildContext context, int carouselIndex) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Text('Carousel $carouselIndex'),
//         SizedBox(
//           // you may want to use an aspect ratio here for tablet support
//           height: 200.0,
//           child: PageView.builder(
//             // store this controller in a State to save the carousel scroll position
//             controller: PageController(viewportFraction: 0.8),
//             itemBuilder: (BuildContext context, int itemIndex) {
//               return _buildCarouselItem(context, carouselIndex, itemIndex);
//             },
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildCarouselItem(BuildContext context, int carouselIndex, int itemIndex) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 4.0),
//       child: Container(
//         child: Text(data[itemIndex]['symptom']),
//         decoration: BoxDecoration(
//           color: Colors.grey,
//           borderRadius: BorderRadius.all(Radius.circular(4.0)),
//         ),
//       ),
//     );
//   }
// }


// // // class AnimatedLogo extends AnimatedWidget {
 
// //  import 'package:flutter/material.dart';
  


// // class AnimatedLogo extends AnimatedWidget {
// //   // Make the Tweens static because they don't change.
// //   static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
// //   static final _sizeTween = Tween<double>(begin: 0, end: 300);

// //   AnimatedLogo({Key key, Animation<double> animation})
// //       : super(key: key, listenable: animation);

// //   Widget build(BuildContext context) {
// //     final Animation<double> animation = listenable;
// //     return Center(
// //       child: Opacity(
// //         opacity: _opacityTween.evaluate(animation),
// //         child: Container(
// //           margin: EdgeInsets.symmetric(vertical: 10),
// //           height: _sizeTween.evaluate(animation),
// //           width: _sizeTween.evaluate(animation),
// //           child: FlutterLogo(),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class LogoApp extends StatefulWidget {
// //   _LogoAppState createState() => _LogoAppState();
// // }

// // class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
// //   Animation<double> animation;
// //   AnimationController controller;

// //   @override
// //   void initState() {
// //     super.initState();
// //     controller =
// //         AnimationController(duration: const Duration(seconds: 2), vsync: this);
// //     animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
// //       ..addStatusListener((status) {
// //         if (status == AnimationStatus.completed) {
// //           controller.reverse();
// //         } else if (status == AnimationStatus.dismissed) {
// //           controller.forward();
// //         }
// //       });
// //     controller.forward();
// //   }

// //   @override
// //   Widget build(BuildContext context) => AnimatedLogo(animation: animation);

// //   @override
// //   void dispose() {
// //     controller.dispose();
// //     super.dispose();
// //   }
// // }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FirstAidKit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FirstAidKitState();
  }
}

class FirstAidKitState extends State<FirstAidKit> {
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

   static final url = 'http://10.0.2.2:8000/api/firstAid';

    List data;
  var test;
  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull(url),
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
        title: Text('First Aid Kit'),
        backgroundColor:greencolor,
      ),
      body:  ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: _buildResource,
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
                      data[index]['symptom'],
                      style: TextStyle(fontSize: 55, color: Colors.redAccent),
                    ),
                  ),
          
              ListTile(
                
              leading: Icon(Icons.arrow_right),
              title:
              Text
              (
         data[index]['description'].toString()
                // "symptom"
              ),
            ),
                 
                
          //          ListView(
          //           //  scrollDirection: Axis.vertical,
          // children: <Widget>[
          
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: 
              Text(
                // data[index]['disease'],strutStyle:StrutStyle(fontSize: 14) 
                "description"
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
