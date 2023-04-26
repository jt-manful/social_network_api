import 'package:app_2/logIn.dart';
import 'package:app_2/searchProfile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'createPost.dart';
import 'editProfile.dart';
import 'user.dart';
import 'http_request.dart';
import 'home.dart';
import 'search.dart';
import 'viewProfile.dart';
// import 'package:flutter_session/flutter_session.dart';


class ViewProfile extends StatefulWidget {
  @override


  State<StatefulWidget> createState() {
    return ViewProfileState();
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
    controller: residenceController,
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
  Home(),
  CreatePost(),
  Search(),
  logIn()

];
int _selectedIndex = 0;
NavigationRailLabelType labelType = NavigationRailLabelType.all;
bool showLeading = false;
bool showTrailing = false;
double groupAligment = -1.0;


class ViewProfileState extends State<ViewProfile> {


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
                icon: Icon(Icons.search),
                selectedIcon: Icon(Icons.search),
                label: Text('Search'),
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
                                  child: _buildMajorField(user.major),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: _buildResidenceField(user.residence),
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




//