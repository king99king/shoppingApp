import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/CartScreen.dart';
import 'package:shoppingapp/Data/AppData.dart';

import 'AddToCartFirebase.dart';

class DetailsScreen extends StatefulWidget {

  const DetailsScreen({Key? key, required this.Item}) : super(key: key);
  final CardItem Item;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}


Future<String>  downloadUrl(String imageName) async{

  String downloadURL=await FirebaseStorage.instance.ref(imageName).getDownloadURL();

  return downloadURL;
}



class _DetailsScreenState extends State<DetailsScreen> {
  var num=1;
  List<CartItem> cartItems = List<CartItem>.empty(growable: true);
  List<CardItem> itemsModels = List<CardItem>.empty(growable: true);
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  final User? user = FirebaseAuth.instance.currentUser;
  Color fav = Colors.grey;
  List<FavoriteItems> favoriteItems = List<FavoriteItems>.empty(growable: true);
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
                              stream: FirebaseDatabase.instance.ref().child('${user?.uid ?? "unknownUser"}').child('Cart').onValue,
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
                        child:  FutureBuilder(
                          future: downloadUrl(widget.Item.Img.trim()),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                              return Image(
                                image: NetworkImage(
                                  ' ${snapshot.data}'.trim(),

                                ),
                                width: 130,
                                height: 130,
                              );
                            }else if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            return Container();
                          },
                        ), ),
                    FutureBuilder(
                      future: downloadUrl(widget.Item.Img.trim()),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                          return Image(
                            image: NetworkImage(
                              ' ${snapshot.data}'.trim(),

                            ),
                            width: 130,
                            height: 130,
                          );
                        }else if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                          return Center(child: CircularProgressIndicator(),);
                        }
                        return Container();
                      },
                    ),
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

                      Text("${widget.Item.Place}",style:  GoogleFonts.tajawal(
                        color: Colors.grey[900],
                        fontSize: 20,

                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(widget.Item.Name,
                            style:  GoogleFonts.tajawal(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,height: 1.5,
                            ),),
                          InkWell(
                              onTap: () {
                                //=========================here
                                if (fav == Colors.grey && !(favoriteItems.contains(widget.Item.key))) {
                                  setState(() {
                                    fav = Colors.red;
                                  });
                                  addToFavorite(_scaffoldkey, widget.Item, context);
                                } else if(fav == Colors.red && (favoriteItems.contains(widget.Item.key))){
                                  setState(() {
                                    fav = Colors.grey;
                                  });
                                 deleteFromFavorite(_scaffoldkey,favoriteItems.iterator.current, context);

                                }

                              },
                              child: Icon(
                                Icons.favorite,
                                color: fav,
                                size: 30,
                              )),
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
                        child: Text(widget.Item.Detailes,
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
                                    text: "\$ ${widget.Item.Price}",style: GoogleFonts.tajawal(
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
                    addToCart(_scaffoldkey,widget.Item, context);
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
