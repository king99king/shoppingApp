import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'OM';
  PhoneNumber number = PhoneNumber(isoCode: 'OM');
  //==================================
  String get username => _usernameController.text.trim();
  String get email => _emailController.trim();
  String get password => _passwordController.trim();

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
             resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
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
                    Text("SignUp",style:GoogleFonts.tajawal(
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
                          focusColor: Colors.red,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          //  hintText:'Name' ,
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.drive_file_rename_outline,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Colors.black54,
                          ),

                        ),
                        keyboardType: TextInputType.text,
                        controller: _usernameController,
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.white.withOpacity(0.8),
                      child: InternationalPhoneNumberInput(
                        cursorColor: Colors.black,
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        initialValue: number,
                        textFieldController: controller,
                        formatInput: false,
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.DROPDOWN,
                        ),
                        inputDecoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          //  hintText:'Name' ,
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
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

                    Card(
                      color: Colors.white.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                    InkWell(
                      onTap:()async{
                        final bool? vlid=_formKey.currentState?.validate();
                        final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                        if(newUser != null && vlid ==true){
                          setState(() {
                            showSoinner=true;
                          });
                           Navigator.pushReplacement(
                               context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }

                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
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
                       Text("you already have Account?",
                       style: TextStyle(
                         fontSize: 18,

                       ),),
                       TextButton(
                         child: Text("SignIn",style: TextStyle(
                           fontSize: 20,
                           color: Colors.blue[900]
                         ),),
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
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
