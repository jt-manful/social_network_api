import 'dart:convert';
import 'user.dart';
import 'package:http/http.dart' as http;

String _urlUsers = "https://us-central1-social-network-api-40b62.cloudfunctions.net/social_network_api/users";
String _urlPosts = "https://us-central1-social-network-api-40b62.cloudfunctions.net/social_network_api/posts";

Future <int> createProfile(body) async {

  final uri = Uri.parse(_urlUsers);
  final headers = {'Content-Type': 'application/json'};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  if (response.statusCode == 201) {
    return response.statusCode ;
  }else{
    throw Exception('Failed to create profile');
  }

}



 getUser(String studentID) async {
  final response = await http.get(Uri.parse("$_urlUsers/$studentID"));
  return response.body;

}

Future <int> editProfile(studentID, body) async{
  final uri = Uri.parse("$_urlUsers/$studentID");
  final headers = {'Content-Type': 'application/json'};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  http.Response response = await http.patch(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  if (response.statusCode == 200) {
    String responseBody = response.body;
    return response.statusCode ;
  }else{
    throw Exception('Failed to create profile');
  }
}


Future <int> createPost(body) async {

  final uri = Uri.parse(_urlPosts);
  final headers = {'Content-Type': 'application/json'};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  if (response.statusCode == 201) {
    String responseBody = response.body;
    return response.statusCode ;
  }else{
    throw Exception('Failed to create post');
  }

}



Future<List<dynamic>>getPosts() async {
  final response = await http.get(Uri.parse(_urlPosts));
  if (response.statusCode == 200) {
    final json = "[${response.body}]";

    List<dynamic> postData = jsonDecode(json);

    return  postData;

  } else {
    throw Exception('Failed to retrieve user data');
  }
}
