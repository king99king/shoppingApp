import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shoppingapp/Data/AppData.dart';
import 'package:shoppingapp/HomeScreen.dart';
import 'package:shoppingapp/Widgets/OTPScreen.dart';

import 'authScreens/WelcomeScreen.dart';

class checkoutScreen extends StatefulWidget {
  const checkoutScreen({Key? key}) : super(key: key);

  @override
  _checkoutScreenState createState() => _checkoutScreenState();
}

class _checkoutScreenState extends State<checkoutScreen> {
  List<CartItem> cartItems = List<CartItem>.empty(growable: true);
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  final User? user = FirebaseAuth.instance.currentUser;
  StreamSubscription? connection;
  bool isoffline = false;
  String dropdownValue = 'My location';
  @override
  void initState() {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.bluetooth) {
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

  final _usernameController = TextEditingController();
  String get username => _usernameController.text.trim();
  final _ExpController = TextEditingController();
  String get ExpDate => _ExpController.text.trim();
  final _CVCController = TextEditingController();
  String get CVCnumber => _CVCController.text.trim();
  final TextEditingController PhoneController = TextEditingController();
  String initialCountry = 'OM';
  PhoneNumber number = PhoneNumber(isoCode: 'OM');
  String get PhoneNumber1 => PhoneController.text.trim();
  final _LocationController = TextEditingController();
  String get locationtwo => _LocationController.text.trim();
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: isoffline
              ? const Center(
                  child: Text(
                    "You are offline, \n Please connect your phone",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : FutureBuilder<DocumentSnapshot>(
                  future: users.doc(user?.uid).get(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(user?.email)
                        .get();

                    if (snapshot.hasError) {
                      return const Center(child: Text("Something went wrong"));
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Center(
                          child: Column(
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
                          const Text("you are not SignIn 📧"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WelcomeScreen()));
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    // side: BorderSide(color: Colors.red)
                                  )),
                                  padding: MaterialStateProperty.resolveWith(
                                      (states) => const EdgeInsets.all(22)),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                    (states) => Colors.blueGrey[900],
                                  )),
                              child: Center(
                                child: Center(
                                  child: Text(
                                    "SignIn",
                                    style: GoogleFonts.tajawal(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
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
                      return Container(
                        child: Form(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
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
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "Last Step To get Your Furniture to your Home",
                                    style: GoogleFonts.tajawal(
                                      fontSize: 25,
                                      height: 1.5,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffB9B9B9),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
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
                                          Icons.credit_card,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: 'Bank Account',
                                      hintStyle: TextStyle(
                                        color: Colors.black54,

                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: _usernameController,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 160,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffB9B9B9),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        //  autofillHints:[AutofillHints.name] ,
                                        decoration: const InputDecoration(
                                          focusColor: Colors.red,
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          //  hintText:'Name' ,
                                          icon: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.date_range_outlined,
                                              size: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                          hintText: 'Exp Date: yy-mm',
                                          hintStyle:  TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: _ExpController,
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(
                                                  1900), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101),
                                          );

                                          if (pickedDate != null) {
                                            String formattedDate =DateFormat('yy-MM').format(pickedDate);
                                            setState(() {
                                              _ExpController.text = formattedDate; //set output date to TextField value.
                                            });
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      ),
                                    ),


                                    Container(
                                      width: 150,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffB9B9B9),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: TextFormField(
                                        maxLength: 3,

                                        cursorColor: Colors.black,
                                        //  autofillHints:[AutofillHints.name] ,
                                        decoration: const InputDecoration(
                                          focusColor: Colors.red,
                                          border: InputBorder.none,
                                          contentPadding: const EdgeInsets.all(10),
                                          counterText: "",
                                          //  hintText:'Name' ,
                                          icon: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons
                                                  .confirmation_number_outlined,
                                              size: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                          hintText: 'CVC',
                                          hintStyle: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: _CVCController,
                                      ),
                                    ),
                                  ],
                                ),
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Row(
                                   children: [
                                 Container(
                                   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(30),
                                     color: Colors.blueGrey[900],
                                   ),
                                   child: DropdownButton<dynamic>(
                                   borderRadius: BorderRadius.circular(10),
                                   dropdownColor: Colors.blueGrey[900],
                                   value: dropdownValue,
                                   icon: const Icon(Icons.arrow_downward,color: Colors.white,),
                                   elevation:16,
                                   style: const TextStyle(color: Colors.white,fontSize: 20),
                                   onChanged: (dynamic newValue) {
                                     setState(() {
                                       dropdownValue = newValue!;
                                     });
                                   },
                                   //==============================================================================================here
                                   items:['My location','another location']
                                       .map(( value) {
                                     return DropdownMenuItem<String>(
                                       value: value,
                                       child: Text(value,style: TextStyle(
                                         color: Colors.white,
                                       ),),
                                     );
                                   }).toList(),
                                 ),
                                 )
                                   ],
                                 ),
                               ),
                                Container(
                                child:dropdownValue== "My location" ? Container(
                                  child:  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            Position position =
                                            await _determinePosition();
                                            _getAddress(position);
                                            //getUserDoc();
                                            setState(() {});
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(30.0),
                                                    // side: BorderSide(color: Colors.red)
                                                  )),
                                              padding: MaterialStateProperty
                                                  .resolveWith((states) =>
                                              const EdgeInsets.all(18)),
                                              backgroundColor:
                                              MaterialStateProperty
                                                  .resolveWith(
                                                    (states) => Colors.blueGrey[900],
                                              )),
                                          child: Text(
                                            "Send your Location",
                                            style: GoogleFonts.tajawal(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          )),
                                      Container(
                                        width: 200,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffB9B9B9),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                            child: Text(
                                              data['PersonPlace'] ??
                                                  "get your location",
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
                                ):Container(
                                  child:  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            Position position =
                                            await _determinePosition();
                                            _getAddress(position);
                                            //getUserDoc();
                                            setState(() {});
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(30.0),
                                                    // side: BorderSide(color: Colors.red)
                                                  )),
                                              padding: MaterialStateProperty
                                                  .resolveWith((states) =>
                                              const EdgeInsets.all(18)),
                                              backgroundColor:
                                              MaterialStateProperty
                                                  .resolveWith(
                                                    (states) => Colors.blueGrey[900],
                                              )),
                                          child: Text(
                                            "Send another Location",
                                            style: GoogleFonts.tajawal(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          )),
                                      Container(
                                        width: 150,
                                         padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffB9B9B9),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                            child:TextFormField(
                                              cursorColor: Colors.black,
                                              //  autofillHints:[AutofillHints.name] ,
                                              decoration: const InputDecoration(
                                                focusColor: Colors.red,
                                                border: InputBorder.none,
                                               // contentPadding: const EdgeInsets.all(10),
                                                //  hintText:'Name' ,
                                                hintText: 'location link',
                                                hintStyle: TextStyle(
                                                  color: Colors.black54,

                                                ),
                                              ),
                                              keyboardType: TextInputType.url,
                                              controller: _LocationController,
                                            ),),
                                      ),
                                    ],
                                  ),
                                )


                                ),


                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffB9B9B9),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
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
                                      hintText: 'Phone number',
                                      hintStyle: TextStyle(
                                        height: 0.5,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onInputChanged: (PhoneNumber number) {
                                      print('On Saved: $number');
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    StreamBuilder(
                                        stream: FirebaseDatabase.instance.ref().child('${user?.uid ?? "unknownUser"}').child('Cart').onValue,
                                        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                          var numberItemInCart = 0;
                                          if (snapshot.hasData) {
                                            var map = (snapshot.data!.snapshot.value ?? {}) as Map<dynamic, dynamic>;
                                            cartItems.clear();
                                            if(map != null) {
                                              map.forEach((key, value) {
                                                var cartItem =
                                                CartItem.fromJson(jsonDecode(jsonEncode(value)));
                                                cartItem.key = key;
                                                cartItems.add(cartItem);
                                                numberItemInCart = cartItems
                                                    .map<int>((m) => m.quantity)
                                                    .reduce((s1, s2) => s1 + s2);
                                              });

                                            }return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:const Color(0xffB9B9B9),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Text("Total Items:",style: GoogleFonts.tajawal(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),),
                                                      Center(child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text("$numberItemInCart",style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        )),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );

                                          }else{

                                            return   Text.rich(
                                              TextSpan(
                                                text: "Total items:  ",
                                                style: GoogleFonts.tajawal(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color:const Color(0xffB9B9B9),
                                                ),
                                                children: const <InlineSpan>[
                                                  TextSpan(
                                                      text:"0",
                                                      style:  TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                      )),
                                                ],
                                              ),
                                            );
                                          }}

                                    ),
                                    StreamBuilder(
                                        stream: FirebaseDatabase.instance.ref().child('${user?.uid ?? "unknownUser"}').child('Cart').onValue,
                                        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                          var totalPriceCart = 0.0;
                                          if (snapshot.hasData) {
                                            var map = (snapshot.data!.snapshot.value ?? {}) as Map<dynamic, dynamic>;
                                            cartItems.clear();
                                            if(map != null) {
                                              map.forEach((key, value) {
                                                var cartItem =
                                                CartItem.fromJson(jsonDecode(jsonEncode(value)));
                                                cartItem.key = key;
                                                cartItems.add(cartItem);
                                                totalPriceCart = cartItems
                                                    .map<double>((m) => m.totalPrice)
                                                    .reduce((s1, s2) => s1 + s2);
                                              });

                                            }return   Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(0xffB9B9B9),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                        Text("Total Price:",style: GoogleFonts.tajawal(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.white,
                                                      ),),
                                                      Center(child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text("\$${totalPriceCart}",style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        )),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );

                                          }else{

                                            return  const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.red,
                                              ),
                                            );
                                          }}

                                    ),
                                  ],
                                ),


                                ElevatedButton(
                                  onPressed: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                         OtpScreen()));

                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            // side: BorderSide(color: Colors.red)
                                          )),
                                      padding: MaterialStateProperty.resolveWith(
                                              (states) => const EdgeInsets.all(22)),
                                      backgroundColor: MaterialStateProperty.resolveWith(
                                            (states) => Colors.blueGrey[900],
                                      )),
                                  child: const Center(
                                    child: Text(
                                      "Pay",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Center(
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
                          const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    );
                  })),
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
  List<Placemark> placemark =
      await placemarkFromCoordinates(position.latitude, position.longitude);

  Placemark place = placemark[0];
  print(place.street);
  print(place.locality);

  final userLocation = <String, dynamic>{
    "PersonPlace": "${place.locality}-${place.street}",
    "LocationOnMap":
        "https://www.google.com/maps/dir/${position.latitude},${position.longitude}"
  };
  FirebaseFirestore.instance
      .collection("users")
      .doc(user?.uid)
      .update(userLocation);
}

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

