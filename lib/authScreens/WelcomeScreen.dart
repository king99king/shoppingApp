import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/HomeScreen.dart';
import 'package:shoppingapp/authScreens/SignUpScreen.dart';

import 'SignInScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  StreamSubscription? connection;
  bool isoffline = false;
  @override
  void initState() {
    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.ethernet){
        //connection is from wired connection
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.bluetooth){
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
        });
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signInAnonymously() {
    _auth.signInAnonymously().then((result) {
      setState(() {
        final User? user = result.user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: isoffline? Center(child:
          Text("You are offline, \n Please connect your phone",style: TextStyle(
            fontSize: 30,

          ),
          textAlign: TextAlign.center,),):Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fbg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(

            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 50),
                child: Center(
                  child: Text("Welcome to the \n Furniture Store",style:GoogleFonts.tajawal(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                  ),),
                ),
              ),
             InkWell(
               onTap: (){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                 },
               child: Container(
                 margin: EdgeInsets.fromLTRB(0, 50, 0, 30),
                 padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                 decoration: BoxDecoration(
                   color: Colors.white.withOpacity(0.7),
                   borderRadius: BorderRadius.circular(30),
                     border: Border.all(color: Colors.grey),
                 ),
                 child: Text("SignUp",style: GoogleFonts.tajawal(
                   fontSize:30,
                   height: 1.5
                 ),),
               ),
             ),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 40),
                  padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text("SignIn",style: GoogleFonts.tajawal(
                      fontSize:30,
                      height: 1.5
                  ),),
                ),
              ),
              InkWell(
                onTap: ()async{

                  signInAnonymously();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScreen()),(route) => false,);
                },
                child: Container(
                  margin: EdgeInsets.all(20),

                  padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text("SignIn as Gust",style: GoogleFonts.tajawal(
                      fontSize:30,
                      height: 1.5
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
