import 'dart:convert';

import 'package:app_2/searchProfile.dart';

import 'createProfile.dart';
import 'http_request.dart';
import 'logIn.dart';
import 'viewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
//import 'package:flutter_session/flutter_session.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchState();
  }
}

class SearchState extends State<Search>{
  TextEditingController studentIDController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  Widget _buildStudentIDField() {
    return TextFormField(
        controller: studentIDController,
        decoration: InputDecoration(
          labelText: 'Enter Student ID',
          prefixIcon: Icon(
            Icons.account_balance_outlined,
            color: Colors.white70,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'id is Required';
          }
        }
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

              children: [

                SizedBox(height: 200,),
                Center(
                  child: Container(
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(8.0),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.white60, Colors.white70],
                      ),
                    ),
                    width: 600,
                    height: 300,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'SEARCH PROFILE',
                          style: TextStyle(
                            fontFamily: "Signatra",
                            fontSize: 50.0,
                            color: Colors.black12,
                          ),
                        ),
                        _buildStudentIDField(),

                        const SizedBox(height: 20.0),

                        ElevatedButton(
                            child: const Text(
                              'Search',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () async{
                              String studentData = await getUser(studentIDController.text);
                              var responseData = jsonDecode(studentData);
                              User searchedUserData = User(
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
                              // ignore: use_build_context_synchronously
                            if (searchedUserData.studentID != null){
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => SearchProfile(),
                                  settings: RouteSettings(
                                    arguments:  {
                                      "arg1": user,
                                      "arg2": searchedUserData,
                                    },
                                  ),
                                ),
                              );
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Invalid Student ID.'),
                                  )
                              );
                            }


                            }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),)
          ],

        )
    );
  }

}