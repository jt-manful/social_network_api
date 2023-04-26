import 'package:app_2/createPost.dart';
import 'package:app_2/logIn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'editProfile.dart';
import 'user.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'http_request.dart';
import 'home.dart';
import 'viewProfile.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'reusable_widgets.dart';


class TestProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestProfileState();
  }
}

class TestProfileState extends State<TestProfile>{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController studentIDController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController yearGroupController = TextEditingController();
  TextEditingController residenceController = TextEditingController();
  TextEditingController bestMovieController = TextEditingController();
  TextEditingController bestFoodController = TextEditingController();

  String _major="Computer Science";
  String _residence="Off-Campus";

  var pages = [
    Home(),
    CreatePost(),
    logIn(),
  ];
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAligment = -1.0;

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      body: Row(

         children: <Widget>[

              NavigationRail(
                selectedIndex: _selectedIndex,
                groupAlignment: groupAligment,
                onDestinationSelected: (int index) {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (_context) => pages[_selectedIndex],
                      settings: RouteSettings(
                        arguments: user,
                      ),
                    ),
                  );
                  setState(() {
                    _selectedIndex = index;
                  },
                  );
                },

                destinations: const <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.post_add_outlined),
                    selectedIcon: Icon(Icons.post_add_outlined),
                    label: Text('Post'),
                  ),

                  NavigationRailDestination(
                    icon: Icon(Icons.logout),
                    selectedIcon: Icon(Icons.logout),
                    label: Text('Logout'),
                  ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              // This is the main content.
            Expanded(child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                const Text(
                  'PROFILE',
                  style: TextStyle(
                    fontFamily: "Signatra",
                    fontSize: 50.0,
                    color: Colors.black12,
                  ),
                ),
                Center(
                  child: Container(
                      width: 800.0,
                      height: 500.0,
                      margin: EdgeInsets.all(50.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.white60, Colors.white70],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white60,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Name:${user.name}",
                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                    ),
                                  ),

                                ]
                            ),
                            SizedBox(height: 15),
                            Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: 150,
                                      child: Text(
                                        "Email:${user.studentID}",
                                        style: TextStyle(fontSize: 20, color: Colors.black),
                                      ),),                              ),

                                  SizedBox(width: 5,),
                                  Expanded(
                                    child: SizedBox(
                                      width: 150,
                                      child: Text(
                                        "StudentID:${user.email}",
                                        style: TextStyle(fontSize: 20, color: Colors.black),
                                      ),
                                    ),

                                  ),
                                ]
                            ),
                            SizedBox(height: 15),
                            Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "DOB:${user.dob}",
                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                    ),),

                                  SizedBox(width: 5,),
                                  Expanded(child: Text("Major:${user.major}", style: TextStyle(fontSize: 20, color: Colors.black),),
                                  ),
                                ]
                            ),
                            SizedBox(height: 15),
                            Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Year Group:${user.yearGroup}",
                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Expanded(
                                    child: Text(
                                      "Residence:${user.residence}",
                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                ]
                            ),
                            SizedBox(height: 15),
                            Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Best Movie:${user.bestMovie}",
                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Expanded(
                                    child: Text(
                                      "Best Food:${user.bestFood}",
                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                ]
                            ),
                            SizedBox(height: 20,),

                            SizedBox(height: 100),
                            ElevatedButton(
                                child: const Text(
                                  'Edit Profile',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (_context) => EditProfile(),
                                      settings: RouteSettings(
                                        arguments: user,
                                      ),
                                    ),
                                  );

                                }
                            ),

                          ],
                        ),)
                  ),
                ),
              ],
            ))
            ],
            ),
          );
  }
}




