import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_app/screens/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class LoginScreen extends StatefulWidget {

  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore =FirebaseFirestore.instance;
  bool showSpinner = false;
  String email;
  String password;


  // void getTasks() async {
  //   final tasks = await _firestore.collection('tasks').get();
  //   for (var task in tasks.docs){
  //     print(task.data());
  //   }
  // }

  void tasksStream() async {
   await for(var snapshot in _firestore.collection('tasks').snapshots()){
     for (var task in snapshot.docs){
       print(task.data());
     }
   }
  }


  // final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: ModalProgressHUD(
        color: Colors.purple,
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/todo_logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                // key: _formKey,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                style: TextStyle(color: Colors.white,fontSize: 20),
                decoration: InputDecoration(
                  // errorText: 'Invalid email-address',errorStyle: TextStyle(fontSize: 16,color: Colors.red),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.bold),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white70, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                // validator: (String value) {
                //   if(value.isEmpty){
                //     return 'Email is required';
                //   }
                //
                //   if(!RegExp("^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*").hasMatch(value)){
                //     return 'Enter a valid email address';
                //   }
                //
                //   // validator has to return something :)
                //   return null;
                // },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                // key: _formKey,
                keyboardType: TextInputType.text,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                style: TextStyle(color: Colors.white,fontSize: 20),
                decoration: InputDecoration(
                  // errorText: 're-enter password',errorStyle: TextStyle(fontSize: 16,color: Colors.red),
                  hintText: 'minimum of 6 characters',
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 20,fontWeight: FontWeight.bold),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white70, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                // ignore: missing_return

              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(title: 'Sign-in',colour: Colors.deepOrangeAccent,
                onPressed: () async{
                setState(() {
                  tasksStream();
                  showSpinner = true;
                });
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                  setState(() {
                    showSpinner= false;
                  });
                } catch(e){
                  print('Invalid email and password combination');
                }
                },
    ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 16.0),
              //   child: Material(
              //     color: Colors.deepOrangeAccent,
              //     borderRadius: BorderRadius.all(Radius.circular(30.0)),
              //     elevation: 5.0,
              //     child: MaterialButton(
              //       onPressed: () {
              //         //Implement login functionality.
              //       },
              //       minWidth: 200.0,
              //       height: 42.0,
              //       child: Text(
              //         'Log In',
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
