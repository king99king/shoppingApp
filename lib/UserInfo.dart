import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final String documentId = '1NtyBtfLLQAucO7gLjES';
  // // late dynamic data;
  // //
  // final User? user = FirebaseAuth.instance.currentUser;
  // Future<void> getData() async {
  //
  //   final  document =   FirebaseFirestore.instance.collection("users").doc(user!.email).get();
  //      print(document);
  // }
  // CollectionReference users2 = FirebaseFirestore.instance.collection('users');
  // DocumentSnapshot documentSnapshot=DocumentSnapshot.getData();
  // Future<String> get_data(DocumentReference doc_ref) async {
  //   DocumentSnapshot docSnap = await doc_ref.get();
  //   var doc_id2 = docSnap.reference;
  //   return doc_id2;
  // }
  // @override
  // void initState() {
  //
  //   super.initState();
  //   getData();
  //   print(users2.path);
  //   print(get_data) ;
  // }


//To retrieve the string


  // Future getEmail()async{
  //   SharedPreferences preferences =await SharedPreferences.getInstance();
  //   setState(() {
  //     email =preferences.getString('email');
  //   });
  // }

  //  Future _getUserInfo() async{
  //    FocusScope.of(context).unfocus();
  //    final user = await FirebaseAuth.instance.currentUser!;
  //    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  //    setState(() {
  //      userData[user.uid]['email of user']= email;
  //    });
  //
  //  }
  String? UserId='';
  final User? user = FirebaseAuth.instance.currentUser;
  Future _getUserId() async{

    setState(() {
      UserId=user?.uid;
    });
  }

  //
  //  // final chatDocs = snapshot.data?.docs;
  //  // chatDocs![index]['text'],
  //  // chatDocs[index]['username'],
  //  // chatDocs[index]['userId'] == uid,
  //  // key: ValueKey(chatDocs[index].id),
  //
  @override
  void initState(){
     super.initState();
     _getUserId();
     print(user?.uid);
   }
  // final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return //Text("Full Name: ${data['UserName']} ${data['UserName']}");
                Container(
              decoration: BoxDecoration(
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
                          icon: Icon(
                            Icons.arrow_back,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Hero(
                        tag: 'profile',
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueGrey[900],
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/profile.png"))),
                        ),
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
                            onPressed: () {},
                            child: Text(
                              "Get Location",
                              style: GoogleFonts.tajawal(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                )),
                                padding: MaterialStateProperty.resolveWith(
                                    (states) => EdgeInsets.all(22)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                  (states) => Colors.blueGrey[900],
                                ))),
                        Container(
                          width: 220,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            "Street34-home",
                            style: GoogleFonts.tajawal(
                              height: 1.8,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()));
                        },
                        child: Center(
                          child: Text(
                            "Logout",
                            style: GoogleFonts.tajawal(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              // side: BorderSide(color: Colors.red)
                            )),
                            padding: MaterialStateProperty.resolveWith(
                                (states) => EdgeInsets.all(22)),
                            backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.blueGrey[900],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Text("loading");
        },
      )),
    );
  }
}
