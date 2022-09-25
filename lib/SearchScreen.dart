import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/AddToCartFirebase.dart';
import 'package:shoppingapp/CartScreen.dart';
import 'package:shoppingapp/Data/AppData.dart';
import 'package:shoppingapp/DetailsScreen.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class searchScreen extends StatefulWidget {
  const searchScreen({Key? key}) : super(key: key);

  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }






  List<CategoryListLis> categoryModels = List<CategoryListLis>.empty(growable: true);
  List<CardItem> itemsModels = List<CardItem>.empty(growable: true);
  List<CartItem> cartItems = List<CartItem>.empty(growable: true);
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  final User? user = FirebaseAuth.instance.currentUser;
  late String _SearchConfController = TextEditingController().text;
  String get SearchByCategory => _SearchConfController.trim().toTitleCase();
  String get SearchByName=> _SearchConfController.trim().toTitleCase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10,5,10,1),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 40,
                        color: Colors.black,
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>const CartScreen()));
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
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
                                        padding:const EdgeInsets.all(5),
                                        decoration:const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle
                                        ),
                                        child: Text(numberItemInCart > 9 ? 9.toString() + "+" : numberItemInCart.toString(),style: const TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),)));
                              }else{
                                return  const Text("0",style: TextStyle(
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
           Card(
            color: Colors.white.withOpacity(0.8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child:  TextField(
              autofocus: true,
              focusNode: myFocusNode,

              onChanged: (value) {
                setState(() {
                  _SearchConfController = value;
                });

              },

              cursorColor: Colors.black12,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                labelText: 'Search for Furniture',
                labelStyle: TextStyle(
                  color: Colors.black54,
                ),),
            ),
          ),
              const SizedBox(height: 20,),
              Container(
                child: StreamBuilder(
                    stream: FirebaseDatabase.instance.ref().child('Furniture').onValue,
                    builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.hasData) {
                        var map =
                        snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                        itemsModels.clear();
                        map.forEach((key, value) {
                          var itemsModel =
                          CardItem.fromJson(jsonDecode(jsonEncode(value)));
                          itemsModel.key = key;
                          itemsModels.add(itemsModel);
                        });
                        return Expanded(
                          child: GridView(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            children: itemsModels.where((element) =>
                            element.category.contains(SearchByCategory) || element.Name.contains(SearchByName) || element.Place.contains(SearchByCategory)).map((e) {
                              return BestDealItem(
                                Img: '${e.Img}',
                                Place: '${e.Place}',
                                Name: '${e.Name}',
                                Discount: e.discount,
                                Price: '${e.Price}',
                                Index: e,scaffoldkey: _scaffoldkey,items:e,context: context,
                              );
                            }).toList(),
                          ),
                        );
                      }else{
                        return  const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }
                    }
                ),
              ) ],
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

class BestDealItem extends StatefulWidget {
  const BestDealItem({Key? key,  required this.Img, required this.Place, required this.Name, required this.Price, required this.Discount, required this.Index, this.scaffoldkey, this.items, this.context}) : super(key: key);
  // final int index;
  final String Img;
  final String Place;
  final String Name;
  final String Price;
  final bool Discount;
  final  Index;
  final scaffoldkey;
  final items;
  final context;
  @override
  _BestDealItemState createState() => _BestDealItemState();
}

class _BestDealItemState extends State<BestDealItem> {
  Color fav=Colors.white;
  int index=0;
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>DetailsScreen(
            Item: widget.Index,
          ),),);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
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
                  onTap: (){
                    setState(() {
                      if(fav==Colors.white){
                        fav=Colors.red;
                        ListOfFavorite.add(ListOfItems[1]);
                      }else{
                        fav=Colors.white;
                      }

                    });
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                            text: "Price: ",
                            style: GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: "\$ ${widget.Price}",
                                style: const TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  decorationThickness: 2,
                                ),
                              ),
                            ],
                          )),

                    ],
                  ),
                  InkWell(
                    onTap: (){
                      addToCart(widget.scaffoldkey, widget.items, widget.context);
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.blueGrey[900],
                          padding: const EdgeInsets.all(5),
                          child: const Center(
                            child: const Icon(
                              Icons.shopping_bag,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        )),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
