

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_firebase_app/screens/landing_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_firebase_app/components/clockview.dart';
import 'package:animated_text_kit/animated_text_kit.dart';



class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
      var now = DateTime.now();
      var formattedTime = DateFormat('HH:mm').format(now);
      var formattedDate = DateFormat('EEE, d MMM').format(now);
      return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
              formattedTime,
              style: TextStyle(color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              formattedDate,
              style: TextStyle(color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.bold,),
            ),
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    height: 20,
                  ),
                  ClockView(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    // ignore: deprecated_member_use
                    child: TypewriterAnimatedTextKit(
                      text: [
                        'Good Time Management enables an individual to complete more in a shorter period of time, lower stress and leads to career success',
                      ],
                      textStyle: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: Duration(milliseconds: 500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      'CLICK the button below to get started...........',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,fontFamily: 'amatic',
                      ),
                    ),
                  ),
                ],
               ),
            ],
              ),
            ),
          ),
        floatingActionButton: FloatingActionButton(child: Center(
          child: Icon(Icons.assignment_rounded, color: Colors.white),),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
          },
          backgroundColor: Colors.purpleAccent,
        ),
    );
    }
  }



