import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/Data/AppData.dart';
import 'package:shoppingapp/authScreens/WelcomeScreen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {

  String? UserId = '';
  final User? user = FirebaseAuth.instance.currentUser;
  Future _getUserId() async {
    setState(() {
      UserId = user?.uid;
    });
  }



  StreamSubscription? connection;
  bool isoffline = false;
  @override
  void initState() {
    _getUserId();
     print(user?.uid);
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

  // final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      body: SafeArea(
          child: isoffline? Center(child:
          Text("You are offline, \n Please connect your phone",style: TextStyle(
            fontSize: 30,

          ),
            textAlign: TextAlign.center,),):FutureBuilder<DocumentSnapshot>(
        future: users.doc(user?.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          FirebaseFirestore.instance.collection("users").doc(user?.email).get();

          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return  Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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

                Text("you are not SignIn 📧"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomeScreen()),(route)=>false);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          // side: BorderSide(color: Colors.red)
                        )),
                        padding: MaterialStateProperty.resolveWith(
                                (states) => const EdgeInsets.all(22)),
                        backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.blueGrey[900],
                        )),
                    child: Center(
                      child: Center(
                        child: Text(
                          "SignIn",
                          style: GoogleFonts.tajawal(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return //Text("Full Name: ${data['UserName']} ${data['UserName']}");
                Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/fbg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blueGrey[900],
                            image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/profile.png"))),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 250,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                              child: Text(
                            data['UserName'],
                            style: GoogleFonts.tajawal(
                              height: 1.8,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )),
                        ),
                      ),
                    ),
                    Text(
                      "Email",
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          data['email of user'],
                          style: GoogleFonts.tajawal(
                            height: 1.8,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )),
                      ),
                    ),
                    Text(
                      "phone number",
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          data['PhoneNumber'],
                          style: GoogleFonts.tajawal(
                            height: 1.8,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )),
                      ),
                    ),
                    Text(
                      "Location",
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () async {
                              Position position = await _determinePosition();
                              _getAddress(position);
                               //getUserDoc();
                              setState(() {});
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                )),
                                padding: MaterialStateProperty.resolveWith(
                                    (states) => const EdgeInsets.all(22)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                  (states) => Colors.blueGrey[900],
                                )),
                            child: Text(
                              "Get Location",
                              style: GoogleFonts.tajawal(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )),
                        Container(
                          width: 220,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            data['PersonPlace'] ?? "get your location",
                            style: GoogleFonts.tajawal(
                              height: 1.8,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.visible,
                            maxLines: 1,
                          )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                        showAlertDialogLogOut(context);
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              // side: BorderSide(color: Colors.red)
                            )),
                            padding: MaterialStateProperty.resolveWith(
                                (states) => const EdgeInsets.all(22)),
                            backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.blueGrey[900],
                            )),
                        child: Center(
                          child: Center(
                            child: Text(
                              "Logout",
                              style: GoogleFonts.tajawal(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return  Center(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      )),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

final User? user = FirebaseAuth.instance.currentUser;
Future<void> _getAddress(Position position) async {
  List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);

  Placemark place = placemark[0];
  print(place.street);
  print(place.locality);


  final userLocation = <String, dynamic>{
    "PersonPlace": "${place.locality}-${place.street}",
    "LocationOnMap":"https://www.google.com/maps/dir/${position.latitude},${position.longitude}"
  };
  FirebaseFirestore.instance.collection("users").doc(user?.uid).update(userLocation);
}

// Future<void> getUserDoc() async {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   User? user = await _auth.currentUser;
//   DocumentReference ref = _firestore.collection('users').doc(user?.uid);
//   return ref.set({'userId': user?.uid});
// }

void showAlertDialogLogOut(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("Yes"),
    onPressed: ()async {

     await  FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
      builder: (context) => const WelcomeScreen()), (route) => false);}

);
  Widget noButton = TextButton(
    child: const Text("No"),
    onPressed: ()=>  Navigator.pop(context),

  );

  // set up the AlertDialog
  AlertDialog alert =  AlertDialog(


    title: const Text("Logout!"),
    content: Text("Are you sure ",style: GoogleFonts.tajawal(
      fontSize: 25,
    ),textAlign: TextAlign.center,),
    actions: [
      noButton,
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