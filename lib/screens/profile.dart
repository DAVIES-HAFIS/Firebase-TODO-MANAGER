import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/landing_page.dart';


class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  String email = FirebaseAuth.instance.currentUser.email;
  User loggedInUser;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print('No logged in user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text('YOUR PROFILE PAGE', style: TextStyle(fontWeight:FontWeight.bold, fontSize:20, color: Colors.white ),),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'welcome.............$email',
                style: TextStyle(color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,fontFamily: 'amatic',),
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100,
                    child: Icon(Icons.person, size: 100, color: Colors.pink,),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                   Text(
                      'YOU WILL NEVER CHANGE YOUR LIFE UNTIL YOU CHANGE SOMETHING YOU DO DAILY. THE SECRET OF YOUR SUCCESS IS FOUND IN YOUR DAILY ROUTINE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,fontFamily: 'amatic',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Unlock the door to greatness by clicking on the button below........',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Center(
        child: Icon(Icons.lock_rounded, color: Colors.pink),),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
          );
        },
        backgroundColor: Colors.white,
      ),
    );
  }
}

