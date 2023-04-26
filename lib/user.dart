import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final String studentID;
  final String name;
  final String email;
  final String dob;
  final String yearGroup;
  final String major;
  final String residence;
  final String bestFood;
  final String bestMovie;


  User({
    required this.studentID,
    required this.name,
    required this.email,
    required this.dob,
    required this.yearGroup,
    required this.major,
    required this.residence,
    required this.bestFood,
    required this.bestMovie,
  });

  factory User.fromJson(Map<String, dynamic> json) {
  return User(
  studentID: json['student_id'],
  name: json['name'],
  email: json['email'],
  dob: json['dob'],
  yearGroup: json['year-group'],
  major: json['major'],
  residence: json['residence'],
  bestFood: json['best-food'],
  bestMovie: json['best-movie'],


  );
  }
}


