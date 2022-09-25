import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/AddToCartFirebase.dart';
import 'package:shoppingapp/CartScreen.dart';
import 'package:shoppingapp/Data/AppData.dart';
import 'package:shoppingapp/DetailsScreen.dart';
import 'package:shoppingapp/Widgets/CategoryList.dart';

class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({Key? key, required this.Cat1}) : super(key: key);
  final CategoryListLis Cat1;

  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  List<CardItem> itemsModels = List<CardItem>.empty(growable: true);
  List<FavoriteItems> favoriteItems = List<FavoriteItems>.empty(growable: true);
  List<CartItem> cartItems = List<CartItem>.empty(growable: true);
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                              builder: (context) => const CartScreen()));
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
              RichText(
                  text: TextSpan(
                text: "Category: ",
                style: GoogleFonts.tajawal(
                  color: Colors.black,
                  fontSize: 25,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: "${widget.Cat1.name}",
                    style: GoogleFonts.tajawal(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 15,
              ),
              Container(
                child: StreamBuilder(
                    stream: FirebaseDatabase.instance
                        .ref()
                        .child('Furniture')
                        .onValue,
                    builder: (BuildContext context,
                        AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.hasData) {
                        var map = snapshot.data!.snapshot.value
                            as Map<dynamic, dynamic>;
                        itemsModels.clear();
                        map.forEach((key, value) {
                          var itemsModel =
                              CardItem.fromJson(jsonDecode(jsonEncode(value)));
                          itemsModel.key = key;
                          itemsModels.add(itemsModel);
                        });
                        return Expanded(
                          child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            children: itemsModels
                                .where((element) =>
                                    element.category == widget.Cat1.name)
                                .map((e) {
                              return CategoryItems(
                                Img: '${e.Img}',
                                Place: '${e.Place}',
                                Name: '${e.Name}',
                                Discount: e.discount,
                                Price: '${e.Price}',
                                numItems: e.numItemsSold,
                                scaffoldkey: _scaffoldkey,
                                items: e,
                                context: context,
                                Key1: e.key,
                                lis: favoriteItems,
                              );
                            }).toList(),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }
                    }),
              )
            ],
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

class CategoryItems extends StatefulWidget {
  const CategoryItems(
      {Key? key,
      required this.Img,
      required this.Place,
      required this.Name,
      required this.Price,
      required this.Discount,
      required this.numItems,
      this.scaffoldkey,
      this.items,
      this.context,
      required this.Key1,
      required this.lis,})
      : super(key: key);
  final String Key1;
  final String Img;
  final String Place;
  final String Name;
  final String Price;
  final int numItems;
  final bool Discount;
  final scaffoldkey;
  final items;
  final context;
  final List lis;
  @override
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  Color fav = Colors.white;
  List<FavoriteItems> favoriteItems = List<FavoriteItems>.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              Item: widget.items,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[100],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              child: InkWell(
                  onTap: () {
                      //=========================here
                      if (fav == Colors.white && !(widget.lis.contains(widget.Key1))) {
                        setState(() {
                          fav = Colors.red;
                        });
                        addToFavorite(widget.scaffoldkey, widget.items, context);
                      } else if(fav == Colors.red && (widget.lis.contains(widget.Key1))){
                        setState(() {
                          fav = Colors.white;
                        });
                        deleteFromFavorite(widget.scaffoldkey, widget.items, context);

                      }

                  },
                  child: Icon(
                    Icons.favorite,
                    color: fav,
                    size: 30,
                  )),
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
                children: [
                  Text(
                    widget.Place,
                    style: GoogleFonts.tajawal(
                      color: Colors.grey[900],
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.Name,
                    style: GoogleFonts.tajawal(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                    text: "${widget.numItems}",
                    style: GoogleFonts.tajawal(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: " items sold",
                        style: GoogleFonts.tajawal(
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
                      Text(
                        "Price: \$ ${widget.Price}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          addToCart(widget.scaffoldkey, widget.items, widget.context);
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.black,
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Icon(
                                  Icons.shopping_bag,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            )),
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
