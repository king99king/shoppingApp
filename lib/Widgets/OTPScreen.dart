import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:shoppingapp/HomeScreen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    showAlertDialog1(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                  ),
                ),
              ],

            ),
            Text("Enter code",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            Text("* * * * * *",
              style: TextStyle(
                height: 0.3,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.blueGrey[900],
              ),),
            Text("we have sent you on SMS on +968 ******** \n"
                "with 6 digit verification code.",textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                height: 1.5,
                fontSize:20,
                color: Colors.black,
              ),),
            Container(

              decoration: BoxDecoration(
                color: const Color(0xffB9B9B9),
                borderRadius: BorderRadius.circular(10),
              ),
              height:250,
              padding: EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PinCodeTextField(
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      errorBorderColor: Colors.red,
                      pinBoxHeight: 50,
                      pinBoxWidth: 45,
                      pinBoxRadius: 5,
                      defaultBorderColor: Colors.white,
                      pinBoxDecoration: ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                    ),
                  ),
                  InkWell(
                    onTap:(){


                       ClearCart(_scaffoldkey,context);
                       showAlertDialog1(context);

                    },
                    child: Container(
                      height: 47,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:Colors.blueGrey[900],
                      ),
                      child:Center(
                        child: Text("Verify",
                          style: GoogleFonts.tajawal(
                            height: 1.5,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                    ),
                  ),
                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Did not receive the code?",
                style: TextStyle(
                  fontSize:14,
                  color: Colors.black,
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("RESEND",
                style: TextStyle(
                  fontSize:16,
                  color: Colors.blue[900],
                ),),
            ),

          ],
        ),
      ),
    ),
    );
  }
}
final User? user = FirebaseAuth.instance.currentUser;

void ClearCart(GlobalKey<ScaffoldState> scaffoldkey, BuildContext context) {
  var cart = FirebaseDatabase.instance.ref().child('${user?.uid ?? "unknownUser"}').child('Cart');
  cart.remove().then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      elevation: 5,
      content: Text(
        "Payment Done Successfully",
      ))))
      .catchError((e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      elevation: 5,
      content: Text(
        '$e',
      ))));
}

void showAlertDialog1(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: ()=>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
        HomeScreen() ), (route) => false),

  );

  // set up the AlertDialog
  AlertDialog alert =  AlertDialog(


    //title: Text("alert!"),
    content: Text("your shipment will be delivered to your home soon...",style: GoogleFonts.tajawal(
        fontSize: 25,
      fontWeight: FontWeight.bold
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
