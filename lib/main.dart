import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/home_screen.dart';
import 'package:flutter_firebase_app/screens/landing_page.dart';
import 'package:flutter_firebase_app/screens/welcome_screen.dart';
import 'package:flutter_firebase_app/screens/login_screen.dart';
import 'package:flutter_firebase_app/screens/registration_screen.dart';
import 'package:flutter_firebase_app/screens/chat_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.alexBrushTextTheme(Theme.of(context).textTheme)
      ),
      routes:{
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LandingPage.id: (context) => LandingPage(),
        HomeScreen.id: (context) => HomeScreen(),

      },
      home: AnimatedSplashScreen(
        backgroundColor: Colors.white,
        duration: 3000,
        splash:CircleAvatar(backgroundImage:AssetImage('images/bird.jpeg'),radius: 50,),
        nextScreen: WelcomeScreen(),
        splashTransition:SplashTransition.scaleTransition,
        ),
    );
  }
}

//firebase-id: task-manager-4a51d