import 'dart:convert';
import 'createProfile.dart';
import 'http_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class logIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return logInState();
  }
}

class logInState extends State<logIn>{
  TextEditingController emailController = TextEditingController();
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Column(

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
                      'THE SOCIAL NETWORK',
                      style: TextStyle(
                        fontFamily: "Signatra",
                        fontSize: 50.0,
                        color: Colors.black12,
                      ),
                    ),
                    _buildStudentIDField(),
                    SizedBox(height: 10),
                    const SizedBox(height: 5.0),
                    RichText(
                      text: TextSpan(
                        children: [

                          const TextSpan(
                            text: "Don't have a Profile? ",
                            style: TextStyle(
                              fontSize: 15.0,

                            ),
                          ),
                          TextSpan(
                            text: "Create Profile",
                            style: const TextStyle(
                              fontSize: 15.0,
                              // Set the font size of the hyperlink text
                              color: Colors
                                  .blue, // Set the color of the hyperlink text
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (
                                      context) =>  CreateProfile()), // Navigate to Create Profile Page
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    ElevatedButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () async{
                          String studentData = await getUser(studentIDController.text);
                          var responseData = jsonDecode(studentData);
                          User user = User(
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
                          if (user.studentID != null){
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (_context) => Home(),
                                settings: RouteSettings(
                                  arguments: user ,
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
        )
    );
  }

}