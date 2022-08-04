import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/CartScreen.dart';
import 'package:shoppingapp/Data/AppData.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  List<CartItem> cartItems = List<CartItem>.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
        CartScreen()));
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration:BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(10),

            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: Colors.blueGrey[900],
                  size: 30,
                ),
                Text("cart",
                style: GoogleFonts.tajawal(
                  fontSize: 20,
                ),),
              ],
            ),
          ),

             StreamBuilder(stream: FirebaseDatabase.instance.ref().child('Cart').child('UNIQUE_USER_ID').onValue,
                builder: (BuildContext context,
                    AsyncSnapshot<DatabaseEvent> snapshot) {
                  var numberItemInCart = 0;
                  if (snapshot.hasData) {
                    Map<dynamic, dynamic> map = (snapshot.data!.snapshot.value ??{}) as Map<dynamic, dynamic>;
                    cartItems.clear();
                    if (map != null) {map.forEach((key, value) {var cartItem = CartItem.fromJson(jsonDecode(jsonEncode(value)));
                        cartItem.key = key;
                        cartItems.add(cartItem);
                      });
                      numberItemInCart = cartItems
                          .map<int>((m) => m.quantity)
                          .reduce((s1, s2) => s1 + s2);
                    }
                    return Align(
                        alignment:Alignment.topRight,
                    child:Container(
                        padding:EdgeInsets.all(5),
                        decoration:BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                        ),
                        child: Text(numberItemInCart > 9 ? 9.toString() + "+" : numberItemInCart.toString(),style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),)));
                  }else{
                    return  Align(
                    alignment:Alignment.topRight,
                    child: Container(
                        padding:EdgeInsets.all(5),
                        decoration:BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                        ),
                        child: Text("0",style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),)));
                  }

                }
            ),
        ],
      ),
    );
  }
}
