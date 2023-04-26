import 'dart:convert';

import 'package:app_2/logIn.dart';
import 'package:app_2/search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'createPost.dart';
import 'editProfile.dart';
import 'user.dart';
import 'http_request.dart';
import 'home.dart';
import 'viewProfile.dart';


class SearchProfile extends StatefulWidget {
  @override


  State<StatefulWidget> createState() {
    return SearchProfileState();
  }

}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController studentIDController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController majorController = TextEditingController();
TextEditingController yearGroupController = TextEditingController();
TextEditingController residenceController = TextEditingController();
TextEditingController bestMovieController = TextEditingController();
TextEditingController bestFoodController = TextEditingController();
TextEditingController searchController = TextEditingController();


String _major="Computer Science";
String _residence="Off-Campus";


// standard way to use forms in flutter
// This key uniquely identifies the form and
// allows you to do any validation in the form fields.
final _formKey = GlobalKey<FormState>();

var course_items =[
  "Computer Science",
  "Business Administration",
  "Management Information Systems",
  "Electrical Engineering",
  "Mechanical Engineering",
  "Computer Engineering"];

var residence_items =[
  "Off-Campus",
  "On-Campus"];

@override
Widget _buildNameField(String initialValue){
  nameController.text = initialValue;
  return TextFormField(
    controller: nameController,
    decoration: InputDecoration(labelText: 'Name',),
    readOnly: true,
  );
}

Widget _buildEmailField(String initialValue) {
  emailController.text = initialValue;
  return TextFormField(
    controller: emailController,
    decoration: InputDecoration(labelText: 'Email'),
    readOnly: true,

  );
}

Widget _buildStudentIDField(String initialValue){
  studentIDController.text =initialValue;
  return TextFormField(
    controller: studentIDController,
    decoration: InputDecoration(labelText: 'Student ID'),
    readOnly: true,
  );
}

Widget _buildDOBField(String initialValue){
  dobController.text = initialValue;
  return TextFormField(
    controller: dobController,
    decoration: InputDecoration(labelText: 'Date Of Birth'),
    readOnly: true,

  );
}

Widget _buildYearGroupField(String initialValue){
  yearGroupController.text = initialValue;
  return  TextFormField(
    controller: yearGroupController,
    decoration: InputDecoration(labelText: 'Year Group'),
    readOnly: true,

  );
}

Widget _buildMajorField(String initialValue){
  majorController.text = initialValue;
  return TextFormField(
    controller: majorController,
    decoration: InputDecoration(labelText: 'Major'),
    readOnly: true,);
}

Widget _buildResidenceField(String initialValue){
  residenceController.text = initialValue;
  return TextFormField(
    controller: majorController,
    decoration: InputDecoration(labelText: 'Residence'),
    readOnly: true,);
}

Widget _buildBestMovieField(String initialValue){
  bestMovieController.text =initialValue;
  return TextFormField(
    controller: bestMovieController,
    decoration: InputDecoration(labelText: 'Best Movie'),
    readOnly: true,
  );
}

Widget _buildBestFoodField(String initialValue){
  bestFoodController.text = initialValue;
  return TextFormField(
    controller: bestFoodController,
    decoration: InputDecoration(labelText: 'Best Food'),
    readOnly: true,
  );
}

var pages = [
  ViewProfile(),
  Home(),
  logIn()

];
int _selectedIndex = 0;
NavigationRailLabelType labelType = NavigationRailLabelType.all;
bool showLeading = false;
bool showTrailing = false;
double groupAligment = -1.0;


class SearchProfileState extends State<SearchProfile> {

  @override
  Widget build(BuildContext context) {
    Map<String, User> args = ModalRoute.of(context)!.settings.arguments as Map<String, User>;
    User? user = args['arg1'];
    User? searchedUserData = args['arg2'];
    // print(user!.studentID);
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
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person),
                label: Text('Person'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
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
                'SEARCHED PROFILE',
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
                                  child: _buildNameField(searchedUserData!.name),
                                ),

                              ]
                          ),
                          SizedBox(height: 15),
                          Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: 150,
                                    child: _buildStudentIDField(searchedUserData!.studentID),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: SizedBox(
                                    width: 150,
                                    child: _buildEmailField(searchedUserData.email),
                                  ),

                                ),
                              ]
                          ),
                          SizedBox(height: 15),
                          Row(
                              children: [
                                Expanded(
                                  child: _buildDOBField(searchedUserData!.dob),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: _buildYearGroupField(searchedUserData!.yearGroup),
                                ),
                              ]
                          ),
                          SizedBox(height: 15),
                          Row(
                              children: [
                                Expanded(
                                  child: _buildMajorField(searchedUserData!.major),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: _buildResidenceField(searchedUserData!.residence),
                                ),
                              ]
                          ),
                          SizedBox(height: 15),
                          Row(
                              children: [
                                Expanded(
                                  child: _buildBestMovieField(searchedUserData!.bestMovie),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: _buildBestFoodField(searchedUserData!.bestFood),
                                ),
                              ]
                          ),
                          SizedBox(height: 20,),

                          ElevatedButton(
                              child: const Text(
                                'Search Again',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (_context) => Search(),
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
