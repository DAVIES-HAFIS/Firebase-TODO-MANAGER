import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/login_screen.dart';
import 'package:flutter_firebase_app/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_firebase_app/components/rounded_button.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 6),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);

    controller.forward();

    animation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(controller);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/todo_logo_1.jpeg'),
                  ),
                ),
                height: 300,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                // ignore: deprecated_member_use
                child: TypewriterAnimatedTextKit(
                  text: [
                    'The key is not spending time, but investing it..',
                  ],
                  textStyle: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                  speed: Duration(milliseconds: 1000),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RoundedButton(
                onPressed: () {
                  //Go to login screen.
                  Navigator.pushNamed(
                    context,
                    LoginScreen.id,
                  );
                },
                title: 'Sign-in',
                colour: Colors.orangeAccent,

              ),
              RoundedButton(
                title: 'Sign-up',
                onPressed: () {
                  //Go to login screen.
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                colour: Colors.purple,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
