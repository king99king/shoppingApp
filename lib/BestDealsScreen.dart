import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/AddToCartFirebase.dart';
import 'package:shoppingapp/CartScreen.dart';
import 'package:shoppingapp/Data/AppData.dart';
import 'package:shoppingapp/DetailsScreen.dart';

class BestDealsScreen extends StatefulWidget {
  const BestDealsScreen({Key? key}) : super(key: key);

  @override
  _BestDealsScreenState createState() => _BestDealsScreenState();
}

class _BestDealsScreenState extends State<BestDealsScreen> {
  List<CategoryListLis> categoryModels = List<CategoryListLis>.empty(growable: true);
  List<CardItem> itemsModels = List<CardItem>.empty(growable: true);
  List<CartItem> cartItems = List<CartItem>.empty(growable: true);
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  String dropdownValue = 'Chair';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10,5,10,1),
          child: Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Best Deals On " ,style:GoogleFonts.tajawal(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    height: 1.8,
                  ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueGrey[900],
                    ),
                    child: StreamBuilder(
                      stream: FirebaseDatabase.instance.ref().child('CatList').onValue,
                      builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.hasData) {
                      var map =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                      categoryModels.clear();
                      map.forEach((key, value) {
                      var categoryModel =
                      CategoryListLis.fromJson(jsonDecode(jsonEncode(value)));
                      categoryModel.key = key;
                      categoryModels.add(categoryModel);
                      });
                      return DropdownButton<dynamic>(
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.blueGrey[900],
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward,color: Colors.white,),
                        elevation:16,
                        style: const TextStyle(color: Colors.white,fontSize: 20),
                        onChanged: (dynamic newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        //==============================================================================================here
                        items:categoryModels
                            .map(( value) {
                          return DropdownMenuItem<String>(

                            value: value.name,
                            child: Text(value.name,),
                          );
                        }).toList(),
                      );
                    }else{
                        return   Text('no data');
                      }
                      }
                    ),
                  ),


                ],
              ),
              Align(
               alignment: Alignment.topLeft,
                child:  Container(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.yellowAccent[700],
                  ),

                  child: Text("20% OFF",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ),),
                ),
              ),
              SizedBox(height: 20,),
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
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            children: itemsModels.where((element) =>
                            element.category == dropdownValue).map((e) {
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
                        return  Center(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                            text: "before: ",
                            style: GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: widget.Price,
                                style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2,
                                ),
                              ),
                            ],
                          )),
                      RichText(
                          text: TextSpan(
                            text: "now: ",
                            style: GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: "\$96",
                                style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
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
                ]),
          ],
        ),
      ),
    );
  }
}
