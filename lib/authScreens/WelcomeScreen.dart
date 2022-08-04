import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/HomeScreen.dart';
import 'package:shoppingapp/authScreens/SignUpScreen.dart';

import 'SignInScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fbg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
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
                 margin: EdgeInsets.all(20),
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
                  margin: EdgeInsets.all(20),
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
                onTap: (){

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
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
