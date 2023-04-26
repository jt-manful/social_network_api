import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatScreenState();
  }
}
  class ChatScreenState extends State<ChatScreen> {
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
        getMessages();
      });


    }


    Future<void>getMessages() async {
      String _urlPosts = "http://127.0.0.1:8080/message";

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

  @override
  Widget build(BuildContext context) {
    //final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(body: Row(

    ));
    }
}
