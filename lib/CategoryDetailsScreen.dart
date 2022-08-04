import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
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
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
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
                              builder: (context) =>const CartScreen()));
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
                        Align(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              child: Text("0")),
                          alignment: Alignment.topRight,
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
                child:StreamBuilder(
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
              return  Expanded(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    children: itemsModels.where(
                            (element) => element.category == widget.Cat1.name)
                        .map((e) {
                      return CategoryItems( Img: '${e.Img}', Place: '${e.Place}',Name: '${e.Name}', Discount:e.discount, Price: '${e.Price}', Index: e,numItems: e.numItemsSold,scaffoldkey: _scaffoldkey,items:e,context: context,Key1: e.key, lis: itemsModels,tt: favoriteItems,);
                    }).toList(),
                  ),
                );}else{
                  return  Center(
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

class CategoryItems extends StatefulWidget {
  const CategoryItems({Key? key, required this.Img, required this.Place, required this.Name, required this.Price, required this.Discount, this.Index, required this.numItems, this.scaffoldkey, this.items, this.context, required this.Key1, required this.lis, this.tt}) : super(key: key);
  final String Key1;
  final String Img;
  final String Place;
  final String Name;
  final String Price;
  final int numItems;
  final bool Discount;
  final  Index;
  final scaffoldkey;
  final items;
  final context;
  final List lis;
  final tt;
  @override
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  Color fav=Colors.white;
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
                  onTap: (){
                    setState(() {
                      if(fav==Colors.white && !(widget.lis.contains(widget.Key1)) ){
                        fav=Colors.red;
                        addToFavorite(widget.scaffoldkey, widget.tt[1], widget.context);
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
             Image(
              image: AssetImage(
                widget.Img,
              ),
              width: 130,
              height: 130,
              fit: BoxFit.fitWidth,
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
                        "${widget.Price}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: (){
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
