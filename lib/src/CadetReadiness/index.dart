// import 'package:esdm/src/CadetReadiness/lari12.dart';
// import 'package:esdm/src/CadetReadiness/lari8.dart';
// import 'package:esdm/src/CadetReadiness/pullup.dart';
// import 'package:esdm/src/CadetReadiness/pushup.dart';
// import 'package:esdm/src/CadetReadiness/renang.dart';
// import 'package:esdm/src/CadetReadiness/situp.dart';
// import 'package:esdm/src/CadetReadiness/testkesehatan.dart';

import 'lari12.dart';
import 'lari8.dart';
import 'pullup.dart';
import 'pushup.dart';
import 'renang.dart';
import 'situp.dart';
import 'testkesehatan.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CadetReadiness extends StatefulWidget {
  @override
  State createState() => _CadetReadinessState();
}

enum FormType { login, register }

class _CadetReadinessState extends State<CadetReadiness> {
  bool visibilitySitUp = false;
  bool visibilityPushUp = false;
  var titleTest = [
    "Push Up",
    "Sit Up",
    "Pull Up",
    "Renang",
    "Lari 8",
    "Lari 12",
    "Test Kesehatan"
  ];
  int page = 0;

  CarouselSlider title, body;

  // void _changed(bool visibility, String field) {
  //   setState(() {
  //     if (field == "SitUp") {
  //       visibilitySitUp = visibility;
  //     }
  //     if (field == "PushUp") {
  //       visibilityPushUp = visibility;
  //     }
  //   });
  // }

  // void _changedPosition(int position) {
  //   setState(() {
  //     page = position;
  //   });
  // }

  // Timer _timer;
  // int _start = 0;

  // void startTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) => setState(
  //       () {
  //         if (_start < 0) {
  //           timer.cancel();
  //         } else {
  //           _start = _start + 1;
  //         }
  //       },
  //     ),
  //   );
  // }

  // List<Widget> getWidget() {
  //   List<Widget> cadetWidget = [
  //     PushUp(),
  //     SitUp(),
  //     PullUp(),
  //     Renang(),
  //     Lari8(),
  //     Lari12(),
  //     TestKesehatan()
  //   ];

  //   return cadetWidget;
  // }

  int _selectedTabIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: SvgPicture.asset("lib/assets/fonts/sit-up.svg",height: 35,color: Colors.blue[900],),title: Text('Sit Up'),),
      BottomNavigationBarItem(icon: SvgPicture.asset("lib/assets/fonts/push-up.svg",height: 35,color: Colors.blue[900]), title: Text('Push Up')),
      BottomNavigationBarItem(icon: SvgPicture.asset("lib/assets/fonts/swimming-pool.svg",height: 35,color: Colors.blue[900]), title: Text('Renang')),
      BottomNavigationBarItem(icon: SvgPicture.asset("lib/assets/fonts/training.svg",height: 35,color: Colors.blue[900]), title: Text('Pull Up')),
      BottomNavigationBarItem(icon: SvgPicture.asset("lib/assets/fonts/tracking.svg",height: 35,color: Colors.blue[900]),title: Text('Lari 8'),),
      BottomNavigationBarItem(icon: SvgPicture.asset("lib/assets/fonts/track.svg",height: 35,color: Colors.blue[900]), title: Text('Lari 12')),
      BottomNavigationBarItem(icon: SvgPicture.asset("lib/assets/fonts/hospital.svg",height: 35,color: Colors.blue[900]), title: Text('Tes Sehat')),
    ];

    final _bottomNavBar = BottomNavigationBar(
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      onTap: _onNavBarTapped,
      fixedColor: Colors.blue[900],
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
    // title = CarouselSlider(
    //   height: 80.0,
    //   enableInfiniteScroll: false,
    //   initialPage: 0,
    //   onPageChanged: (index) {
    //     body.jumpToPage(index);
    //   },
    //   items: titleTest.map((i) {
    //     return Builder(
    //       builder: (BuildContext context) {
    //         return new Container(
    //           width: MediaQuery.of(context).size.width,
    //           margin: new EdgeInsets.symmetric(horizontal: 5.0),
    //           decoration: new BoxDecoration(color: Colors.black),
    //           child: new Text(
    //             i,
    //             style: TextStyle(
    //               fontSize: 20.0,
    //               color: Colors.white
    //             ),
    //             textAlign: TextAlign.center,
    //           ),
    //           alignment: Alignment.center,
    //         );
    //       },
    //     );
    //   }).toList(),
    // );

    // body = CarouselSlider(
    //   height: MediaQuery.of(context).size.height - 210,
    //   enableInfiniteScroll: false,
    //   initialPage: 0,
    //   onPageChanged: (index) {
    //     title.jumpToPage(index);
    //   },
    //   items: getWidget().map((i) {
    //     return Builder(
    //       builder: (BuildContext context) {
    //         return Container(
    //           width: MediaQuery.of(context).size.width,
    //           margin: EdgeInsets.symmetric(horizontal: 5.0),
    //           child: i,
    //           alignment: Alignment.center,
    //         );
    //       },
    //     );
    //   }).toList(),
    // );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Cadet Readiness'),
          backgroundColor: Colors.blue[900],
        ),
        // body: new ListView(
        //   children: <Widget>[
        //     new Container(margin: new EdgeInsets.only(top: 20), child: title),
        //     new Container(margin: new EdgeInsets.only(top: 20), child: body),
        //   ],
        // )

        body: [ 
          SitUp(),
          PushUp(),
          Renang(),
          PullUp(),
          Lari8(),
          Lari12(),
          TestKesehatan()
      ].elementAt(_selectedTabIndex),
      bottomNavigationBar: SafeArea(
        child: _bottomNavBar,
      ),     
      
    );
  }
}
