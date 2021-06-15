
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_app/components/database.dart';
import 'package:flutter_firebase_app/screens/home_screen.dart';
import 'package:flutter_firebase_app/screens/login_screen.dart';
import 'package:flutter_firebase_app/screens/registration_screen.dart';
import 'package:flutter_firebase_app/screens/taskpage.dart';
import 'package:flutter_firebase_app/components/widget.dart';
import 'package:flutter_firebase_app/screens/profile.dart';
import 'package:flutter_firebase_app/screens/welcome_screen.dart';

class LandingPage extends StatefulWidget {
  static const String id = 'landing_page_screen';
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
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

  AnimationController _animationController;

  String email = FirebaseAuth.instance.currentUser.email;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat();
    getCurrentUser();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('TASK MANAGER', style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return CircleAvatar(
        //       radius: 20,
        //       child: IconButton(
        //         icon: const Icon(Icons.menu, color: Colors.purple, size: 20,),
        //         onPressed: () {
        //           Scaffold.of(context).openDrawer();
        //         },
        //         tooltip: MaterialLocalizations
        //             .of(context)
        //             .openAppDrawerTooltip,
        //       ),
        //     );
        //   },
        // ),
        
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          color: Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      margin: EdgeInsets.only(
                        top: 32.0,
                        bottom: 32.0,
                      ),
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       image:DecorationImage(
                         image: AssetImage('images/use.jpeg'),
                         fit: BoxFit.cover,
                       ),
                     ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Taskpage(
                                            task: snapshot.data[index],
                                          ),
                                    ),
                                  ).then(
                                        (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data[index].title,
                                  desc: snapshot.data[index].description,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Taskpage(
                                task: null,
                              )),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.deepPurple],
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 1.0)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(
                      Icons.add, color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}


class MyDrawer extends StatefulWidget{
  final Function onTap;

  MyDrawer({this.onTap});


  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _auth = FirebaseAuth.instance;
  String email = FirebaseAuth.instance.currentUser.email;
  // User loggedInUser;
  //
  // void getCurrentUser() {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //     }
  //   } catch (e) {
  //     print('No logged in user');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/2,
      child:Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      child: CircleAvatar(
                        backgroundColor: Colors.purpleAccent,
                        child: Icon(Icons.people, color:Colors.white),
                      ),
                    ),
                    SizedBox(
                      height:10,
                    ),
                    Text('$email',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontStyle:FontStyle.italic,fontFamily: 'amatic', ),
                    ),

                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.deepPurple,
              child: ListTile(
                leading: Icon(Icons.home, color: Colors.purpleAccent,),
                title: Text('Home',style:TextStyle(fontSize: 20),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black38,
            ),

            InkWell(
              splashColor: Colors.deepPurple,
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.purpleAccent,),
                title: Text('Profile',style:TextStyle(fontSize: 20),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()),);
                },
              ),
            ),

            InkWell(
              splashColor: Colors.deepPurple,
              child: ListTile(
                leading: Icon(Icons.upgrade, color: Colors.purpleAccent,),
                title: Text('Premium Subscription',style:TextStyle(fontSize: 20),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()),);
                },
              ),
            ),

            InkWell(
              splashColor: Colors.deepPurple,
              child: ListTile(
                leading: Icon(Icons.settings, color: Colors.purpleAccent,),
                title: Text('Setting',style:TextStyle(fontSize: 20),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()),);
                },
              ),
            ),
            InkWell(
              splashColor: Colors.deepPurple,
              child: ListTile(
                leading: Icon(Icons.exit_to_app_outlined, color: Colors.purpleAccent,),
                title: Text('Sign-out',style:TextStyle(fontSize: 20),),
                onTap: (){
                  _auth.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
                },
              ),
            ),

          ],
        ),
      ) ,
    );

  }
}