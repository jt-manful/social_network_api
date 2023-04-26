import 'dart:async';
import 'dart:convert';
import 'package:app_2/search.dart';
import 'package:app_2/viewProfile.dart';
import 'package:http/http.dart' as http;
import 'createPost.dart';
import 'package:flutter/material.dart';
import 'http_request.dart';
import 'logIn.dart';
import 'user.dart';
//import 'package:flutter_session/flutter_session.dart';
import 'editProfile.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}


class HomeState extends State<Home> {
//create stream
  final StreamController<List<dynamic>> _streamController = StreamController();

  @override
  void dispose() {
    // stop streaming when app close
    _streamController.close();
  }
  @override
  void initState() {
    super.initState();
    // A Timer method that run every 3 seconds
    Timer.periodic(Duration(seconds: 3), (timer) {
      getPosts();
    });


  }


  Future<void>getPosts() async {
    String _urlPosts = "http://127.0.0.1:8080/posts";

    final response = await http.get(Uri.parse(_urlPosts));
    if (response.statusCode == 200) {
      final json = "[" + response.body + "]";

      List<dynamic> postData = jsonDecode(json);

      //ink is a point from where we can add data into the stream pipe.
      _streamController.sink.add(postData)  ;

    } else {
      throw Exception('Failed to retrieve user data');
    }
  }
  var pages = [
    ViewProfile(),
    CreatePost(),
    Search(),
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
            icon: Icon(Icons.person),
            selectedIcon: Icon(Icons.person),
            label: Text('Profile'),
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
      Expanded(
        child: Container(
        child: Column(
          children:<Widget> [
            SizedBox(height: 15.0,),
            const Text(
              'LIVE FEED',
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 50.0,
                color: Colors.black12,
              ),
            ),

            Expanded(
              child: StreamBuilder<List<dynamic>>(
                stream: _streamController.stream,
                builder: (context,snapdata){
                  switch(snapdata.connectionState){
                    case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
                    default: if(snapdata.hasData){
                      List<dynamic> posts = snapdata.data as List<dynamic>;

                      Map<String,dynamic> feed = posts[0];
                      List<dynamic> OnePost = [];

                      for ( final post in feed.values){OnePost.add(post);}
                      OnePost = OnePost.reversed.toList();
                      return ListView.builder(
                        itemCount: OnePost.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(8),
                              color: Colors.white, child: ListTile(
                            // POST
                            title: Center(
                                child: Text(
                                  OnePost[index]['post']!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Gotham"
                                  ),
                                )
                            ),

                            // EMAIL OF PERSON POSTING
                            subtitle: Center(
                                child: Text(
                                  OnePost[index]['email']!,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Helvetica"
                                  ),
                                )
                            ),

                          )
                          );
                        },
                      );

                    }if (snapdata.hasError) {
                      print(snapdata.error.toString());
                      return Text('error');
                    }
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),

          ],
        ),

      ),),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
              child: Icon(
                  Icons.add,
                  size:35,
                  color:Colors.black,
                  semanticLabel: "Create Post"
              ),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePost(),
                    settings: RouteSettings(
                      arguments: user ,
                    ),
                  ),
                );
              }),
        ),
    ],),
    );
  }
}