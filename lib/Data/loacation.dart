import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<String>  downloadUrl(String imageName) async{

  String downloadURL=await FirebaseStorage.instance.ref('$imageName').getDownloadURL();

  return downloadURL;
}




class displayimg extends StatefulWidget {
  const displayimg({Key? key}) : super(key: key);

  @override
  _displayimgState createState() => _displayimgState();
}

class _displayimgState extends State<displayimg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: downloadUrl("wathes.png"),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
             if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
               return Container(
                 child: Image.network(snapshot.data!) ,
               );
             }else if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
               return Center(child: CircularProgressIndicator(),);
             }
             return Container();
          },



            ),
          ),
        ),
      );

  }
}
































//
//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// class tryImage extends StatefulWidget {
//   const tryImage({Key? key}) : super(key: key);
//
//   @override
//   _tryImageState createState() => _tryImageState();
// }
//
// class _tryImageState extends State<tryImage> {
//   final formKey =GlobalKey<FormState>();
//   File? image1=null;
//  String imgUrl ="assets/images/profile.png";
//
// Future getImage()async{
//   var img= await ImagePicker.platform.pickImage(source: ImageSource.gallery);
//   setState(() {
//     image1=img as File;
//   });
//
// }
// Future _getFromGallery() async {
//   XFile? pickedFile = await ImagePicker().pickImage(
//     source: ImageSource.gallery,
//     maxWidth: 1800,
//     maxHeight: 1800,
//   );
//   if (pickedFile != null) {
//     setState(() {
//       image1 = File(pickedFile.path);
//     });
//   }
// }
//
// sendData()async{
//
//     final imagePath =FirebaseStorage.instance.ref().child(image1!.path);
//     final task= imagePath.putFile(image1!);
//     // Listen for state changes, errors, and completion of the upload.
//     task.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
//       switch (taskSnapshot.state) {
//         case TaskState.running:
//           final progress =
//               100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
//           print("Upload is $progress% complete.");
//           break;
//         case TaskState.paused:
//           print("Upload is paused.");
//           break;
//         case TaskState.canceled:
//           print("Upload was canceled");
//           break;
//         case TaskState.error:
//         // Handle unsuccessful uploads
//           break;
//         case TaskState.success:
//         // Handle successful uploads on complete
//         // ...
//           break;
//       }},
//    // imgUrl =await (await task.whenComplete(() => null)).ref.getDownloadURL();
//    //  await FirebaseFirestore.instance.collection("").add(
//    //    {
//    //      "name":imgUrl.toString(),
//    //    }
//
//     );
//
//
// }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child:Column(
//             children: [
//               Padding(padding: EdgeInsets.all(8),
//               child:  InkWell(
//                 onTap: ()=>_getFromGallery(),
//                 child: Container(
//                   child: image1 == null
//                       ? Container(
//                     alignment: Alignment.center,
//                     child: CircleAvatar(
//                       radius: 80,
//                       backgroundColor: Colors.teal,
//                       child: Text("AD",
//                         style: TextStyle(
//                           fontSize: 40,
//                         ),),
//                     ),
//                   ): Center(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         //   borderRadius: BorderRadius.circular(50)
//                       ),
//                       child: CircleAvatar(
//                         radius: 80,
//                         backgroundImage: Image.file(
//                           File(image1!.path.toString()),
//                           fit: BoxFit.cover,).image,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               ) ,
//               TextButton(onPressed:(){
//                 sendData;
//               }, child:Text("ADD")),
//               FutureBuilder(
//
//                 builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//
//                 },
//
//               )
//             ],
//           )
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
// class FireStoreDataBase {
//   String? downloadURL;
//
//   Future getData() async {
//     try {
//       await downloadURLExample();
//       return downloadURL;
//     } catch (e) {
//       debugPrint("Error - $e");
//       return null;
//     }
//   }
//
//   Future<void> downloadURLExample() async {
//     downloadURL = await FirebaseStorage.instance
//         .ref()
//         .child("/wathes.png")
//         .getDownloadURL();
//     debugPrint(downloadURL.toString());
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// //
// // Future<Position> _determinePosition() async {
// //   bool serviceEnabled;
// //   LocationPermission permission;
// //
// //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //   if (!serviceEnabled) {
// //     await Geolocator.openLocationSettings();
// //     return Future.error('Location services are disabled.');
// //
// //   }
// //
// //   permission = await Geolocator.checkPermission();
// //   if (permission == LocationPermission.denied) {
// //     permission = await Geolocator.requestPermission();
// //     if (permission == LocationPermission.denied) {
// //       return Future.error('Location permissions are denied');
// //     }
// //   }
// //
// //   if (permission == LocationPermission.deniedForever) {
// //     return Future.error(
// //         'Location permissions are permanently denied, we cannot request permissions.');
// //   }
// //   return await Geolocator.getCurrentPosition();
// // }
// //
// //
// // Future<void> _getAddress(Position position) async{
// //   List<Placemark> placemark=await placemarkFromCoordinates(position.latitude, position.longitude);
// //   print(placemark);
// // }
// //
// // // // late dynamic data;
// // // //
// // // final User? user = FirebaseAuth.instance.currentUser;
// // // Future<void> getData() async {
// // //
// // //   final  document =   FirebaseFirestore.instance.collection("users").doc(user!.email).get();
// // //      print(document);
// // // }
// // // CollectionReference users2 = FirebaseFirestore.instance.collection('users');
// // // DocumentSnapshot documentSnapshot=DocumentSnapshot.getData();
// // // Future<String> get_data(DocumentReference doc_ref) async {
// // //   DocumentSnapshot docSnap = await doc_ref.get();
// // //   var doc_id2 = docSnap.reference;
// // //   return doc_id2;
// // // }
// // // @override
// // // void initState() {
// // //
// // //   super.initState();
// // //   getData();
// // //   print(users2.path);
// // //   print(get_data) ;
// // // }
// //
// // //To retrieve the string
// //
// // // Future getEmail()async{
// // //   SharedPreferences preferences =await SharedPreferences.getInstance();
// // //   setState(() {
// // //     email =preferences.getString('email');
// // //   });
// // // }
// //
// // //  Future _getUserInfo() async{
// // //    FocusScope.of(context).unfocus();
// // //    final user = await FirebaseAuth.instance.currentUser!;
// // //    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
// // //    setState(() {
// // //      userData[user.uid]['email of user']= email;
// // //    });
// // //
// //  }