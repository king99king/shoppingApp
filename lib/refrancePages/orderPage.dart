// import 'dart:convert';
//
// import 'package:badges/badges.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:shoppingapp/AddToCartFirebase.dart';
// import 'package:shoppingapp/model/cart_model.dart';
// import 'package:shoppingapp/model/drink_model.dart';
//
// import 'cart_deatails_Screen.dart';
//
// class OrderPage extends StatefulWidget {
//   const OrderPage({Key? key}) : super(key: key);
//
//   @override
//   _OrderPageState createState() => _OrderPageState();
// }
//
// class _OrderPageState extends State<OrderPage> {
//   GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
//   List<DrinkModel> drinkModels = List<DrinkModel>.empty(growable: true);
//   List<CartModel> cartModels = List<CartModel>.empty(growable: true);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldkey,
//       appBar: AppBar(
//         title: Text("cart"),
//         actions: [
//           StreamBuilder(
//               stream: FirebaseDatabase.instance
//                   .ref()
//                   .child('Cart')
//                   .child('UNIQUE_USER_ID')
//                   .onValue,
//               builder: (BuildContext context,
//                   AsyncSnapshot<DatabaseEvent> snapshot) {
//                 var numberItemInCart = 0;
//
//                 if (snapshot.hasData) {
//                   Map<dynamic, dynamic> map = (snapshot.data!.snapshot.value ??
//                       {}) as Map<dynamic, dynamic>;
//                   cartModels.clear();
//                   if (map != null) {
//                     map.forEach((key, value) {
//                       var cartModel =
//                           CartModel.fromJson(jsonDecode(jsonEncode(value)));
//                       cartModel.key = key;
//                       cartModels.add(cartModel);
//                     });
//                     numberItemInCart = cartModels
//                         .map<int>((m) => m.quantity)
//                         .reduce((s1, s2) => s1 + s2);
//                   }
//
//                   return GestureDetector(
//                     onTap: () {
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => cartDetailsScreenFire()));
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Center(
//                           child: Badge(
//                               badgeContent: Text(
//
//                                   //cartModels.length
//                                   numberItemInCart > 9 ? 9.toString() + "+" : numberItemInCart.toString()),
//                               badgeColor: Colors.red,
//                               showBadge: true,
//                               child: const Icon(
//                                 Icons.shopping_cart,
//                                 size: 40,
//                               ))),
//                     ),
//                   );
//                 } else {
//                   numberItemInCart = 0;
//                   return Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Center(
//                       child: Badge(
//                           badgeColor: Colors.red,
//                           badgeContent: const Text("0"),
//                           showBadge: true,
//                           child: const Icon(Icons.shopping_cart)),
//                     ),
//                   );
//                 }
//               })
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             StreamBuilder(
//               stream: FirebaseDatabase.instance.ref().child('Drink').onValue,
//               builder: (BuildContext context,
//                   AsyncSnapshot<DatabaseEvent> snapshot) {
//                 if (snapshot.hasData) {
//                   var map =
//                       snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
//                   drinkModels.clear();
//                   map.forEach((key, value) {
//                     var drinkModel =
//                         new DrinkModel.fromJson(jsonDecode(jsonEncode(value)));
//                     drinkModel.key = key;
//                     drinkModels.add(drinkModel);
//                   });
//                   return Expanded(
//                     child: GridView.builder(
//                       itemCount: drinkModels.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         childAspectRatio: 2 / 3,
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 2,
//                         crossAxisSpacing: 2,
//                       ),
//                       itemBuilder: (BuildContext context, int index) {
//                         return InkWell(
//                           child: GestureDetector(
//                             onTap: () {
//                               //add to cart
//                               addToCart(_scaffoldkey, drinkModels[index], context);
//                             },
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   child: Image.network(
//                                       "${drinkModels[index].image}"),
//                                 ),
//                                 Text('${drinkModels[index].name}'),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 } else
//                   return Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.red,
//                     ),
//                   );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
