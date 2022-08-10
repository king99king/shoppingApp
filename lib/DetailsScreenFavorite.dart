import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/CartScreen.dart';
import 'package:shoppingapp/Data/AppData.dart';

import 'AddToCartFirebase.dart';

class DetailsScreenFavorite extends StatefulWidget {

  const DetailsScreenFavorite({Key? key, required this.Item1}) : super(key: key);
  final FavoriteItems Item1;
  //final CardItem Item;
  @override
  State<DetailsScreenFavorite> createState() => _DetailsScreenFavoriteState();
}

class _DetailsScreenFavoriteState extends State<DetailsScreenFavorite> {
  var num=1;
  List<CardItem> itemsModels = List<CardItem>.empty(growable: true);
  List<CartItem> cartItems = List<CartItem>.empty(growable: true);
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold (

      body: SafeArea (
        child:  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back,size: 40,),

                    ),
                    Text("Details",style:  GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()));
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.blueGrey[900],
                              size: 30,
                            ),
                          ),
                          StreamBuilder(
                              stream: FirebaseDatabase.instance.ref().child('Cart').child('UNIQUE_USER_ID').onValue,
                              builder: (BuildContext context,
                                  AsyncSnapshot<DatabaseEvent> snapshot) {
                                var numberItemInCart = 0;
                                if (snapshot.hasData) {
                                  Map<dynamic, dynamic> map = (snapshot.data!.snapshot.value ??{}) as Map<dynamic, dynamic>;
                                  cartItems.clear();
                                  if (map.isNotEmpty) {map.forEach((key, value) {var cartItem = CartItem.fromJson(jsonDecode(jsonEncode(value)));
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
                                  return  Text("0",style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ));
                                }

                              }
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                ImageSlideshow(
                  height: 260,
                  isLoop: true,indicatorBackgroundColor:  Colors.blueGrey,
                  indicatorColor: Colors.blueGrey[800],

                  children: [
                    Hero(
                        tag: 'item',
                        child: Image(image: AssetImage(widget.Item1.Img,),width: 250,height: 250,)),
                    Image(image: AssetImage(widget.Item1.Img,),width: 250,height: 250,),
                  ],

                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        margin: EdgeInsets.all(2.5),
                        padding: EdgeInsets.all(3.0),
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color:Colors.black),
                        ),
                        child: Container(
                          decoration:BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,

                          ),

                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2.5),
                        padding: EdgeInsets.all(3.0),
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color:Colors.black),
                        ),
                        child: Container(
                          decoration:BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,

                          ),

                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2.5),
                        padding: EdgeInsets.all(3.0),
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color:Colors.black),
                        ),
                        child: Container(
                          decoration:BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.teal[700],
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[

                      Text(widget.Item1.Place,style:  GoogleFonts.tajawal(
                        color: Colors.grey[900],
                        fontSize: 20,

                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(widget.Item1.Name,
                            style:  GoogleFonts.tajawal(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,height: 1.5,
                            ),),
                        ],
                      ),
                      Row(

                        children: [
                          Icon(Icons.star,color: Colors.yellow[600],),
                          Icon(Icons.star,color: Colors.yellow[600],),Icon(Icons.star,color: Colors.yellow[600],),
                          Icon(Icons.star,color: Colors.yellow[600],),Icon(Icons.star,color: Colors.yellow[600],),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,15,0,10),
                        child: Text(widget.Item1.Detailes,
                          style:  GoogleFonts.tajawal(
                            color: Colors.grey[700],
                            fontSize: 18,

                          ),textAlign: TextAlign.justify,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text.rich(
                            TextSpan(
                              text: "Price:  ",style:  GoogleFonts.tajawal(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                              children: <InlineSpan>[
                                TextSpan(
                                    text: widget.Item1.Price,style: GoogleFonts.tajawal(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )
                                ),],),),


                          RichText(text: TextSpan(
                            text: "33",style: GoogleFonts.tajawal(
                            color: Colors.black,
                            fontSize: 16,fontWeight: FontWeight.bold,
                          ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: " items sold",style: GoogleFonts.tajawal(
                                color: Colors.grey[600],

                                fontSize: 16,
                              ),
                              ),
                            ],
                          )),
                        ],
                      )
                    ]),
                ElevatedButton(

                  onPressed: (){
                    addToCartFromFavorite(_scaffoldkey,widget.Item1, context);
                  },
                  child: Center(
                    child: Text("Add to Cart",style:  GoogleFonts.tajawal(fontSize: 20,fontWeight: FontWeight.w600),),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            // side: BorderSide(color: Colors.red)
                          )
                      ),
                      padding:  MaterialStateProperty.resolveWith((states) =>EdgeInsets.all(22)),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blueGrey[900],)
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
