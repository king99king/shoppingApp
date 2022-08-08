import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/AddToCartFirebase.dart';
import 'package:shoppingapp/Data/AppData.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = List<CartItem>.empty(growable: true);
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    var num1=0;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 40,
                          color: Colors.black,
                        ))
                  ],
                ),
                Text(
                  "Items Cart",
                  style: GoogleFonts.tajawal(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseDatabase.instance.ref().child('Cart').child('UNIQUE_USER_ID').onValue,
                  builder: (BuildContext context,
                  AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData) {
                  var map = (snapshot.data!.snapshot.value ?? {}) as Map<dynamic, dynamic>;
                  cartItems.clear();
                  if(map != null) {
                    map.forEach((key, value) {
                      var cartItem =
                      CartItem.fromJson(jsonDecode(jsonEncode(value)));
                      cartItem.key = key;
                      cartItems.add(cartItem);
                    });
                  }
                  return cartItems.isNotEmpty ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 500,

                          child: Expanded(
                                    child: ListView.builder(
                                      itemCount: cartItems.length,
                                    itemBuilder: (BuildContext context, int index) {
                                        return ItemWidget(
                                            Img: cartItems[index].image,
                                            Name: cartItems[index].name,
                                            Price: cartItems[index].price,
                                            numItems: cartItems[index].quantity,
                                            context:context,
                                          scaffoldkey: _scaffoldkey,
                                          items: cartItems[index],
                                          totalPrice: cartItems[index].totalPrice,
                                          quantity: cartItems[index].quantity,

                                        );

                                    },

                                  ))

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        StreamBuilder(
                            stream: FirebaseDatabase.instance.ref().child('Cart').child('UNIQUE_USER_ID').onValue,
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

                                }return Text.rich(
                                  TextSpan(
                                    text: "Total items:  ",
                                    style: GoogleFonts.tajawal(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                    ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text:"${numberItemInCart}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                );

                              }else{

                                return   Text.rich(
                                  TextSpan(
                                    text: "Total items:  ",
                                    style: GoogleFonts.tajawal(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                    ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text:"0",
                                          style: TextStyle(
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
                            stream: FirebaseDatabase.instance.ref().child('Cart').child('UNIQUE_USER_ID').onValue,
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

                                }return   Text.rich(
                                  TextSpan(
                                    text: "Total Price:  ",
                                    style: GoogleFonts.tajawal(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                    ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: "\$${totalPriceCart}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )),
                                    ],
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
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          "Proceed to checkout",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            // side: BorderSide(color: Colors.red)
                          )),
                          padding: MaterialStateProperty.resolveWith(
                              (states) => EdgeInsets.all(22)),
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.blueGrey[900],
                          )),
                    ),


                  ],
                ): const Center(
                      child: SizedBox(
                        height: 500,
                        child: Center(child: Text("Empty Cart")),
                      ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
          },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemWidget extends StatefulWidget {
   const ItemWidget(
      {Key? key,
      required this.Img,
      required this.Name,
      required this.Price,
      required this.numItems,
      this.scaffoldkey,
      this.items,
      this.context, required this.quantity, required this.totalPrice})
      : super(key: key);
  final String Img;
  final String Name;
  final String Price;
  final  numItems;
 final int  quantity;
 final double totalPrice;
  final scaffoldkey;
  final items;
  final context;

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffB9B9B9),
        ),
        child: Row(
          children: [
            Image(
              image: AssetImage("${widget.Img}"),
              fit: BoxFit.fitWidth,
              width: 120,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 '${widget.Name}',
                  style: GoogleFonts.tajawal(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: "Price:  ",
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                          text: "\$${widget.Price}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "number of Items:",
                      style: GoogleFonts.tajawal(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    IconButton(
                      onPressed: () async{
                        if(widget.items.quantity >1){
                          widget.items.quantity-=1;
                          widget.items.totalPrice=double.parse(widget.Price)*widget.items.quantity;
                          updateToCart(widget.scaffoldkey,widget.items, context);
                        }

                      },
                      icon: Icon(Icons.indeterminate_check_box_outlined),
                    ),
                    Text(
                      "${widget.quantity}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () async{
                        widget.items.quantity+=1;
                        widget.items.totalPrice=double.parse(widget.Price)*widget.items.quantity;
                        updateToCart(widget.scaffoldkey,widget.items, context);
                      },
                      icon: Icon(Icons.add_box_outlined),
                    ),
                  ],
                ),
                Text('${widget.totalPrice}'),
                ElevatedButton(
                  onPressed: () {
                    deleteCart(widget.scaffoldkey,widget.items, context);
                  },
                  child: Center(
                    child: Text(
                      "Remove the Item",
                      style: GoogleFonts.tajawal(
                        height: 1.5,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        // side: BorderSide(color: Colors.red)
                      )),
                      padding: MaterialStateProperty.resolveWith(
                          (states) => EdgeInsets.all(8)),
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.blueGrey[900],
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
