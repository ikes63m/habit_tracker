import 'package:flutter_application_1/views/home.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/signup.dart';
import 'package:flutter_application_1/views/mainscreen.dart';
import 'package:get/get.dart';

final List<GetPage> routes = [
  GetPage(name: '/', page: () => LoginScreen()),
  GetPage(name: '/signup', page: () => SignupScreen()),
  GetPage(name: '/mainscreen', page: () => MainScreen()),
  GetPage(name: '/home', page: () => HomeScreen()),
];
