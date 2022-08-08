// import 'dart:convert';
// import 'dart:typed_data';
//
// import 'package:badges/badges.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:shoppingapp/AddToCartFirebase.dart';
// import 'package:shoppingapp/model/cart_model.dart';
// import 'package:shoppingapp/model/drink_model.dart';
//
// class cartDetailsScreenFire extends StatefulWidget {
//   const cartDetailsScreenFire({Key? key}) : super(key: key);
//
//   @override
//   _cartDetailsScreenFireState createState() => _cartDetailsScreenFireState();
// }
//
// class _cartDetailsScreenFireState extends State<cartDetailsScreenFire> {
//  List<CartModel> cartModels=  List<CartModel>.empty(growable: true);
//  List<DrinkModel> drinkModels = List<DrinkModel>.empty(growable: true);
//  GlobalKey<ScaffoldState> _scaffoldKey= GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text("cart"),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             StreamBuilder(
//               stream: FirebaseDatabase.instance.ref().child('Cart').child('UNIQUE_USER_ID').onValue,
//               builder: (BuildContext context,
//                   AsyncSnapshot<DatabaseEvent> snapshot) {
//                 if (snapshot.hasData) {
//                   var map = (snapshot.data!.snapshot.value ?? {}) as Map<dynamic, dynamic>;
//                   cartModels.clear();
//                  if(map != null){
//                    map.forEach((key, value) {
//                      var cartModel =
//                       CartModel.fromJson(jsonDecode(jsonEncode(value)));
//                      cartModel.key = key;
//                      cartModels.add(cartModel);
//                    });
//                  }
//                   return cartModels.isNotEmpty ? Expanded(
//                     child: GridView.builder(
//                       itemCount: cartModels.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         childAspectRatio: 2 / 3,
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 2,
//                         crossAxisSpacing: 2,
//                       ),
//                       itemBuilder: (BuildContext context, int index) {
//                         return
//                            GestureDetector(
//                             onTap: () {
//                               //add to cart
//                               addToCart(_scaffoldKey, drinkModels[index],context);
//                             },
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   child: Image.asset(
//                                       "${cartModels[index].image}"),
//                                 ),
//                                 Text('${cartModels[index].name}'),
//                                 Text('${cartModels[index].quantity}',),
//                                 Text('${cartModels[index].price}'),
//                                 Text('${cartModels[index].totalPrice}'),
//
//                                 Row(children: [
//                                       ElevatedButton ( onPressed: () async{
//                                     cartModels[index].quantity+=1;
//                                     cartModels[index].totalPrice=double.parse(cartModels[index].price)*cartModels[index].quantity;
//                         updateToCart(_scaffoldKey, cartModels[index], context);
//                                   },
//                                   child: Icon(Icons.plus_one)),
//                                   TextButton(onPressed: () async{
//                                     if(cartModels[index].quantity >1){
//                                       cartModels[index].quantity-=1;
//                                       cartModels[index].totalPrice=double.parse(cartModels[index].price)*cartModels[index].quantity;
//                                       updateToCart(_scaffoldKey, cartModels[index], context);
//                                     }
//
//
//                                   }, child: Icon(Icons.indeterminate_check_box_outlined)),
//                                   //=======================================================
//                                   TextButton(onPressed: (){
//                                     deleteCart(_scaffoldKey, cartModels[index], context);
//                                   }, child: Icon(Icons.clear)),
//                                 ],)
//                               ],
//                             ),
//                           );
//
//
//                       },
//                     )
//                   ): Center(child: Text("Empty Cart"),);
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
