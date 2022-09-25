import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/Data/AppData.dart';
import 'package:shoppingapp/HomeScreen.dart';
import 'package:shoppingapp/authScreens/SignInScreen.dart';
import 'package:shoppingapp/authScreens/WelcomeScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showSoinner = false;
  final _auth = FirebaseAuth.instance;
  late String _emailController = TextEditingController() as String;
  final _usernameController = TextEditingController();
  late String _passwordController = TextEditingController() as String;
  late String _passwordConfController = TextEditingController() as String;
  //================================
  final TextEditingController PhoneController = TextEditingController();
  String initialCountry = 'OM';
  PhoneNumber number = PhoneNumber(isoCode: 'OM');
  //==================================
  String get username => _usernameController.text.trim();
  String get email => _emailController.trim();
  String get password => _passwordController.trim();
  String get PhoneNumber1 => PhoneController.text.trim();
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



  void _trySubmitForm() {

    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true ) {
      debugPrint('Everything looks good!');
      debugPrint(email);
      debugPrint(password);
      AppData.UserName = username;
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomePageSc()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
             resizeToAvoidBottomInset: true,
      body: SafeArea(
        child:isoffline? Center(child:
        Text("You are offline, \n Please connect your phone",style: TextStyle(
          fontSize: 30,

        ),
          textAlign: TextAlign.center,),): Container(
          padding:  EdgeInsets.fromLTRB(0, 20, 0, 30),
          decoration: const BoxDecoration(
            image: const DecorationImage(
              image: const AssetImage("assets/images/fbg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ModalProgressHUD(
            inAsyncCall: showSoinner,
            child: Form(
              key: _formKey,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                      onPressed: (){
                         Navigator.push(
                             context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
                      },
                      icon:  Icon(Icons.arrow_back_rounded,size: 50,),
                    ),),
                    Padding(
                      padding:  EdgeInsets.fromLTRB(8,30,8,30),
                      child: Text("SignUp",style:GoogleFonts.tajawal(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.white.withOpacity(0.8),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  //  autofillHints:[AutofillHints.name] ,
                                  decoration: const InputDecoration(
                                    focusColor: Colors.red,
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(10),
                                    //  hintText:'Name' ,
                                    icon: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.drive_file_rename_outline,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                    labelText: 'Name',
                                    labelStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),

                                  ),
                                  keyboardType: TextInputType.text,
                                  controller: _usernameController,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.white.withOpacity(0.8),
                                child: InternationalPhoneNumberInput(
                                  cursorColor: Colors.black,
                                  ignoreBlank: false,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  initialValue: number,
                                  textFieldController: PhoneController,
                                  formatInput: false,
                                  selectorConfig: const SelectorConfig(
                                    selectorType: PhoneInputSelectorType.DROPDOWN,
                                  ),
                                  inputDecoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    //  hintText:'Name' ,
                                    icon: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.phone,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                    labelText: 'Phone number',
                                    labelStyle: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onInputChanged: (PhoneNumber number) {
                                    print('On Saved: $number');
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.white.withOpacity(0.8),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  //  autofillHints:[AutofillHints.name] ,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    //  hintText:'Name' ,
                                    icon: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: const Icon(
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
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.white.withOpacity(0.8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    icon: Padding(
                                      padding: EdgeInsets.all(8.0),
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
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.white.withOpacity(0.8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    icon: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.confirmation_num_outlined,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                    labelText: 'confirm password',
                                    labelStyle: TextStyle(
                                      color: Colors.black54,
                                    ),),
                                  keyboardType: TextInputType.visiblePassword,
                                  // controller: _passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field is required';
                                    }

                                    if (value != _passwordController) {
                                      return 'Confirmation password does not match the entered password';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) =>
                                  _passwordConfController = value,
                                ),
                              ),
                            ),

                          ],
                        ),
                    ),
                  

                    InkWell(
                      onTap:()async{
                        final bool? valid=_formKey.currentState?.validate();
                        if(valid ==true){
                        try{  final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                          if(newUser!= null){

                          setState(() {
                            showSoinner=true;
                          });
                          SharedPreferences preferences =await SharedPreferences.getInstance();
                          preferences.setString('email', email);

                          final user1 = await FirebaseAuth.instance.currentUser!;

                          final user = <String, dynamic>{
                            "email of user": email,
                           // "password ": password,
                            "UserName": username,
                           "PhoneNumber": PhoneNumber1,
                            "userId":user1.uid

                          };
                     //     final FirebaseAuth _auth = FirebaseAuth.instance;
                          final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                          DocumentReference ref = _firestore.collection('users').doc(user1.uid);
                          ref.set(user);
//   return ref.set({'userId': user?.uid});
                          // Add a new document with a generated ID
                          // FirebaseFirestore.instance.collection("users").add(user).then((DocumentReference doc) =>
                          //     AppData.UserName=doc.id
                          // );


                           Navigator.pushAndRemoveUntil(
                               context, MaterialPageRoute(builder: (context) => const HomeScreen()),(route)=>false);
                        }}catch(e){
                          showAlertDialogUsedEmail(context);
                        }
                        }

                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[900],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text("SignUp",style: GoogleFonts.tajawal(
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
                       const Text("you already have Account?",
                       style: TextStyle(
                         fontSize: 18,

                       ),),
                       TextButton(
                         child: Text("SignIn",style: TextStyle(
                           fontSize: 20,
                           color: Colors.blue[900]
                         ),),
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignInScreen()));
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

void showAlertDialogUsedEmail(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: ()=>  Navigator.pop(context),

  );

  // set up the AlertDialog
  AlertDialog alert =  AlertDialog(


    //title: Text("alert!"),
    content: Text("The email address is already in use by another account.",style: GoogleFonts.tajawal(
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