import 'package:app_2/logIn.dart';
import 'package:app_2/user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'http_request.dart';
import 'home.dart';
import 'viewProfile.dart';



class CreateProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateProfileState();
  }
}

class CreateProfileState extends State<CreateProfile>{
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
  Widget _buildNameField(){
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

  Widget _buildEmailField() {
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

  Widget _buildStudentIDField(){
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

  Widget _buildDOBField(){
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

  Widget _buildYearGroupField(){
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

  Widget _buildMajorField(){
    return DropdownButton<String>(
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
    );
  }

  Widget _buildResidenceField(){
    return DropdownButton<String>(
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
          _residence = newValue as String;
          residenceController.text = newValue;
        });
      },
    );
  }

  Widget _buildBestMovieField(){
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

  Widget _buildBestFoodField(){
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

  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: Column(
        children: [
          SizedBox(height: 30,),
          Text(
            'CREATE PROFILE',
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
                            child: _buildNameField(),
                          ),

                        ]
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 150,
                            child: _buildStudentIDField(),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: SizedBox(
                            width: 150,
                            child: _buildEmailField(),
                          ),

                        ),
                      ]
                    ),
                    SizedBox(height: 15),
                    Row(
                        children: [
                          Expanded(
                            child: _buildDOBField(),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: _buildYearGroupField(),
                          ),
                        ]
                    ),
                    SizedBox(height: 15),
                    Row(
                        children: [
                          Expanded(
                            child: _buildMajorField(),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: _buildResidenceField(),
                          ),
                        ]
                    ),
                    SizedBox(height: 15),
                    Row(
                        children: [
                          Expanded(
                            child: _buildBestMovieField(),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: _buildBestFoodField(),
                          ),
                        ]
                    ),
                    SizedBox(height: 20,),
                  RichText(
                       text: TextSpan(
                         children: [

                           const TextSpan(
                             text: "Already have a Profile? ",
                             style: TextStyle(
                               fontSize: 15.0, // Set the font size of the title

                             ),
                           ),
                           TextSpan(
                             text: "login",
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
                                       context) =>  logIn()), // Navigate to Create Profile Page
                                 );
                               },
                           ),
                         ],
                       ),
                     ),
                    SizedBox(height: 100),
                    ElevatedButton(
                      child: const Text(
                        'Create Profile',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () async{
                        //Send to API
                        var body = {
                          "student_id": studentIDController.text,
                          "name": nameController.text,
                          "email": emailController.text,
                          "major": majorController.text,
                          "dob": dobController.text,
                          "year-group": yearGroupController.text,
                          "residence": residenceController.text,
                          "best-food": bestFoodController.text,
                          "best-movie": bestMovieController.text
                        };
                        User user = User(
                            studentID: studentIDController.text,
                            name: nameController.text,
                            email: emailController.text,
                            major: majorController.text,
                            dob: dobController.text,
                            yearGroup: yearGroupController.text,
                            residence:  residenceController.text,
                            bestFood: bestFoodController.text,
                            bestMovie: bestMovieController.text
                        );

                        await createProfile(body);
                        ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Form is Submitting.'),
                              )
                          );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Home(),
                          settings: RouteSettings(arguments: user)),
                        );
                      } //onPressed
                    )

                ],
              ),)
            ),
          ),
        ],
      ),
    );
  }
}




