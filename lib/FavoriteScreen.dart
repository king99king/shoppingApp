import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/AddToCartFirebase.dart';
import 'package:shoppingapp/CartScreen.dart';
import 'package:shoppingapp/Data/AppData.dart';
import 'package:shoppingapp/DetailsScreen.dart';
import 'package:shoppingapp/DetailsScreenFavorite.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  List<FavoriteItems> favoriteItems = List<FavoriteItems>.empty(growable: true);
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  List<CardItem> itemsModels = List<CardItem>.empty(growable: true);
  List<CartItem> cartItems = List<CartItem>.empty(growable: true);
  final User? user = FirebaseAuth.instance.currentUser;

  StreamSubscription? connection;
  bool isoffline = false;
  @override
  void initState() {
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: 40,
                            color: Colors.black,
                          )),
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
                  Text(
                    "Favorite Items",
                    style: GoogleFonts.tajawal(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    child: StreamBuilder(
                                stream: FirebaseDatabase.instance.ref().child('${user?.uid ?? "unknownUser"}').child('Favorite').onValue,
                                builder: (BuildContext context,
                                AsyncSnapshot<DatabaseEvent> snapshot) {
                                if (snapshot.hasData) {
                                var map = (snapshot.data!.snapshot.value ?? {}) as Map<dynamic, dynamic>;
                                   favoriteItems.clear();
                                if(map != null){
                                map.forEach((key, value) {
                                var favoriteModel = FavoriteItems.fromJson(jsonDecode(jsonEncode(value)));
                                  favoriteModel.key = key;
                                favoriteItems.add(favoriteModel);
                                });
                                }
                               return favoriteItems.isNotEmpty? Expanded(
                                  child: GridView(
                                    scrollDirection: Axis.vertical,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2/3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 2,

                                    ),
                                   children: favoriteItems.map((e){
                                     return FavoriteItems1(Name: e.Name, Place: e.Place, Price: e.Price, Img:e.Img, numItems: 2,scaffoldkey: _scaffoldkey,items: e,context: context);
                                   }).toList(),
                      )
                         ): const Center(child:SizedBox(
                                 height: 500,
                                 child: Center(child: Text("Empty Cart")),
                               ) );
                                }else{
                                  return const Center(
                                            child: CircularProgressIndicator(color: Colors.red,),);
                                    }
                                }

                                ),
                  )


                ]),
          ),
        ),
      ),
    );
  }
}
Future<String>  downloadUrl(String imageName) async{

  String downloadURL=await FirebaseStorage.instance.ref(imageName).getDownloadURL();

  return downloadURL;
}

class FavoriteItems1 extends StatefulWidget {
  const FavoriteItems1({Key? key, required this.Img, required this.Place, required this.Name, required this.Price, required this.numItems, this.scaffoldkey, this.items, this.context}) : super(key: key);
  final String Img;
  final String Place;
  final String Name;
  final String Price;
  final int numItems;
  final scaffoldkey;
  final items;
  final context;
  @override
  _FavoriteItems1State createState() => _FavoriteItems1State();
}

class _FavoriteItems1State extends State<FavoriteItems1> {
  List<CardItem> itemsModels = List<CardItem>.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreenFavorite(
           //   Item: widget.items,
              Item1: widget.items,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:Colors.blueGrey[100],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:   CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              child: InkWell(
                   onTap: (){
                     deleteFromFavorite(widget.scaffoldkey, widget.items, context);
                   },
                  child: Icon(Icons.remove_circle_outlined,color: Colors.red,size: 30,)),
              alignment: Alignment.topRight,
            ),
            FutureBuilder(
              future: downloadUrl(widget.Img.trim()),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                  return Image(
                    image: NetworkImage(
                      ' ${snapshot.data}'.trim(),

                    ),
                    width: 130,
                    height: 130,
                    fit: BoxFit.fitWidth,                  );
                }else if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                return Container();
              },
            ),
            Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[

                  Text(widget.Place,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,

                  ),),
                  Text(widget.Name,
                    style: GoogleFonts.tajawal(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),

                  RichText(text: TextSpan(
                    text: "${widget.numItems}",style: GoogleFonts.tajawal(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: " items sold",style: GoogleFonts.tajawal(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      ),
                    ],
                  )),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Price: \$${widget.Price}",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                      InkWell(
                        onTap: (){
                          addToCartFromFavorite(widget.scaffoldkey, widget.items, context);
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.black,
                              padding: EdgeInsets.all(5),
                              child:Center( child:Icon(Icons.shopping_bag,color:Colors.white,size: 25,),),
                            )
                        ),
                      ),
                    ],
                  ),

                ]),

          ],
        ),
      ),
    );
  }
}
