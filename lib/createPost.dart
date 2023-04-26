import 'package:flutter/material.dart';
import 'http_request.dart';
import 'home.dart';
import 'home.dart';
import 'viewProfile.dart';
import 'logIn.dart';
import 'user.dart';
//import 'package:flutter_session/flutter_session.dart';


class CreatePost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreatePostState();
  }
}

class CreatePostState extends State<CreatePost>{
  TextEditingController emailController = TextEditingController();
  TextEditingController postTextController = TextEditingController();


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

  Widget _buildPostTextField(){
    return TextFormField(
      controller: postTextController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 40),
          labelText: 'whats on your mind',
        border: OutlineInputBorder(),),
      validator: (value) {
        if (value!.isEmpty) {
          return ' Required';
        }

      },

    );

  }


  var pages = [
    ViewProfile(),
    Home(),
    logIn(),
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

          children: [

            SizedBox(height: 150,),
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
                  height: 450,
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        const Text(
                          'PENNY FOR YOUR THOUGHTS',
                          style: TextStyle(
                            fontFamily: "Signatra",
                            fontSize: 35.0,
                            color: Colors.black12,
                          ),
                        ),
                        SizedBox(height: 10,),
                        _buildEmailField(),
                        SizedBox(height: 15.0,),
                        _buildPostTextField(),

                        SizedBox(height: 30),
                        ElevatedButton(
                            child: const Text(
                              'Post',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () async{
                              //Send to API
                              var body = {
                                "email": emailController.text,
                                "text" : postTextController.text
                              };
                              await createPost(body);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Form is Submitting.'),
                                  )
                              );


                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            } //onPressed
                        )

                      ],
                    ),)
              ),
            ),
          ],
        ),),
      ],

    ),
  );

    }
}