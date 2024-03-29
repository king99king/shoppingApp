import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/HomeScreen.dart';
import 'package:shoppingapp/authScreens/SignUpScreen.dart';
import 'package:shoppingapp/authScreens/WelcomeScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showSoinner = false;
  final _auth = FirebaseAuth.instance;
  late String _emailController = TextEditingController() as String;
  late String _passwordController = TextEditingController() as String;
  String get email => _emailController.trim();
  String get password => _passwordController.trim();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: isoffline? Center(child:
        Text("You are offline, \n Please connect your phone",style: TextStyle(
          fontSize: 30,

        ),
          textAlign: TextAlign.center,),):Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fbg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ModalProgressHUD(
            inAsyncCall: showSoinner,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
                        },
                        icon: Icon(Icons.arrow_back_rounded,size: 50,),
                      ),),
                    Text("SignIn",style:GoogleFonts.tajawal(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),),


                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.white.withOpacity(0.8),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        //  autofillHints:[AutofillHints.name] ,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          //  hintText:'Name' ,
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.email,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          labelText: 'email',
                          labelStyle: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        // controller: _emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          // Return null if the entered email is valid
                          return null;
                        },
                        onChanged: (value) => _emailController = value,
                      ),
                    ),

                    Card(
                      color: Colors.white.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.lock,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          labelText: 'password',
                          labelStyle: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        // controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (value.trim().length < 8) {
                            return 'Password must be at least 8 characters in length';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                        onChanged: (value) =>
                        _passwordController = value,
                      ),
                    ),
                    InkWell(
                      onTap:()async{
                        final bool? vlid=_formKey.currentState?.validate();
                       try{ final user =await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if(user != null && vlid ==true){
                          setState(() {
                            showSoinner=true;
                          });
                         SharedPreferences preferences =await SharedPreferences.getInstance();
                          preferences.setString('email', email);
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false,);
                        }}catch(e){
                         showAlertDialogError(context,'$e');
                       }

                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[900],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text("SignIn",style: GoogleFonts.tajawal(
                          fontSize:25,
                          height: 1.5,
                          color:Colors.white,
                        ),),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("you don't have an Account?",
                          style: TextStyle(
                            fontSize: 18,

                          ),),
                        TextButton(
                          child: Text("SignUp",style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue[900]
                          ),),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));

                          },
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



void showAlertDialogError(BuildContext context,String error) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: ()=>  Navigator.pop(context),

  );

  // set up the AlertDialog
  AlertDialog alert =  AlertDialog(


    //title: Text("alert!"),
    content: Text(error,style: GoogleFonts.tajawal(
      fontSize: 25,
    ),textAlign: TextAlign.center,),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}