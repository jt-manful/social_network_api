import 'dart:convert';

import 'package:app_2/logIn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'http_request.dart';
import 'home.dart';
import 'viewProfile.dart';
// import 'package:flutter_session/flutter_session.dart';


class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfile>{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController studentIDController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController yearGroupController = TextEditingController();
  TextEditingController residenceController = TextEditingController();
  TextEditingController bestMovieController = TextEditingController();
  TextEditingController bestFoodController = TextEditingController();

  String _major = 'Computer Science';
  String _residence = "Off-Campus";



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
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }
      },
    );
  }

  Widget _buildEmailField(String initialValue) {
    emailController.text = initialValue;
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is Required';
        }
        if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

      },

    );
  }

  Widget _buildStudentIDField(String initialValue){
    studentIDController.text =initialValue;
    return TextFormField(
      controller: studentIDController,
      decoration: InputDecoration(labelText: 'Student ID'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'student ID is Required';
        }
        if (value.length != 8 ){
          return 'invalid ID lenght';
        }
      },

    );
  }

  Widget _buildDOBField(String initialValue){
    dobController.text = initialValue;
    return TextFormField(
      controller: dobController,
      decoration: InputDecoration(labelText: 'Date Of Birth'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'date of birth is Required';
        }
      },

    );
  }

  Widget _buildYearGroupField(String initialValue){
    yearGroupController.text = initialValue;
    return  TextFormField(
      controller: yearGroupController,
      decoration: InputDecoration(labelText: 'Year Group'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Year Group is Required';
        }
      },

    );
  }

  Widget _buildMajorField(String initialValue){
    _major = initialValue;
    return DropdownButton<String>(
      value: _major,
      items: course_items.map((String items) {
        return DropdownMenuItem<String>(
          value: items,
          child: Text(
            items,
          ),
        );
      }).toList(),

      onChanged: (String? newValue) {
        _major = newValue!;
        setState(() {
          majorController.text = newValue;

        });
      },
    );
  }

  Widget _buildResidenceField(String initialValue){
    _residence = initialValue;
    return DropdownButton<String>(
      hint: Text("Select Residence"),
      onChanged: (String? newValue) {
        setState(() {
          _residence = newValue!;
          residenceController.text = newValue;
        });
      },value: _residence,
      items: residence_items.map((String items) {
    return DropdownMenuItem<String>(
        value: items,
        child: Text(items));
        }).toList(),
    );
  }

  Widget _buildBestMovieField(String initialValue){
    bestMovieController.text =initialValue;
    return TextFormField(
      controller: bestMovieController,
      decoration: InputDecoration(labelText: 'Best Movie'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Favorite Movie is Required';
        }
      },
    );
  }

  Widget _buildBestFoodField(String initialValue){
    bestFoodController.text = initialValue;
    return TextFormField(
      controller: bestFoodController,
      decoration: InputDecoration(labelText: 'Best Food'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Favorite food is Required';
        }
      },
    );
  }

  var pages = [
    ViewProfile(),
    logIn()

  ];
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAligment = -1.0;

  @override
  Widget build(BuildContext context){
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
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person),
                label: Text('Profile'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout),
                selectedIcon: Icon(Icons.logout),
                label: Text('logout'),
              ),

            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),

          Expanded(child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              const Text(
                'EDIT PROFILE',
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
                                  child: _buildNameField(user.name),
                                ),

                              ]
                          ),
                          SizedBox(height: 15),
                          Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: 150,
                                    child: _buildStudentIDField(user.studentID),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: SizedBox(
                                    width: 150,
                                    child: _buildEmailField(user.email),
                                  ),

                                ),
                              ]
                          ),
                          SizedBox(height: 15),
                          Row(
                              children: [
                                Expanded(
                                  child: _buildDOBField(user.dob),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: _buildYearGroupField(user.yearGroup),
                                ),
                              ]
                          ),
                          SizedBox(height: 15),
                          Row(
                              children: [
                                Expanded(
                                  child: DropdownButton<String>(
                                    value: _major,
                                    hint: Text("Select Major"),
                                    items: course_items.map((String items) {
                                      return DropdownMenuItem<String>(
                                        value: items,
                                        child: Text(
                                          items,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      _major = newValue!;
                                      setState(() {
                                        majorController.text = newValue;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 5,),

              Expanded(
                child: DropdownButton<String>(
                  value: _residence,
                  hint: Text("Select Residence"),
                  items: residence_items.map((String items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(
                        items,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _residence = newValue!;
                    setState(() {
                      residenceController.text = newValue;
                    });
                  },
                ),
              ),
                              ]
                          ),
                          SizedBox(height: 15),
                          Row(
                              children: [
                                Expanded(
                                  child: _buildBestMovieField(user.bestMovie),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: _buildBestFoodField(user.bestFood),
                                ),
                              ]
                          ),
                          SizedBox(height: 20,),
                          //SizedBox(height: 100),
                          ElevatedButton(
                              child: const Text(
                                'Update Profile',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              onPressed: () async{
                                  //Send to API

                                var body = {
                                  "major": majorController.text,
                                  "dob": dobController.text,
                                  "year-group": yearGroupController.text,
                                  "residence": residenceController.text,
                                  "best-food": bestFoodController.text,
                                  "best-movie": bestMovieController.text
                                };
                                await editProfile(studentIDController.text, body);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Form is Submitting.'),
                                    )
                                );
                                String studentData = await getUser(studentIDController.text);
                                var responseData = jsonDecode(studentData);
                                User updatedUser = User(
                                  studentID: responseData['student_id'],
                                  name: responseData['name'],
                                  email: responseData['email'],
                                  dob: responseData['dob'],
                                  yearGroup: responseData['year-group'],
                                  major: responseData['major'],
                                  residence: responseData['residence'],
                                  bestFood: responseData['best-food'],
                                  bestMovie: responseData['best-movie'],
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  ViewProfile(),
                                settings: RouteSettings(arguments: updatedUser),
                                  ),
                                );
                              } //onPressed
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




