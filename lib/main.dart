import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/Data/loacation.dart';
import 'package:shoppingapp/HomeScreen.dart';
import 'package:shoppingapp/authScreens/WelcomeScreen.dart';
import 'package:shoppingapp/refrancePages/orderPage.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences =await SharedPreferences.getInstance();
  var email=preferences.getString('email');

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home:email==null ? WelcomeScreen():HomeScreen()));
}
