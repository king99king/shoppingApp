import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/CartScreen.dart';
import 'package:shoppingapp/Data/AppData.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  List<FavoriteItems> favoriteItems = List<FavoriteItems>.empty(growable: true);
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
                            Align(
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  child: Text("0")),
                              alignment: Alignment.topRight,
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
                                stream: FirebaseDatabase.instance.ref().child('Favorite').child('UNIQUE_USER_ID').onValue,
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
                                favoriteItems.isNotEmpty? Expanded(
                                  child: GridView(
                                    scrollDirection: Axis.vertical,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2/3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 2,

                                    ),
                                   children: ListOfFavorite.map((e){
                                     return FavoriteItems1(Name: '2e', Place: 'qe', Price: 'eq', Img: '', numItems: 2,Discount: true,);
                                   }).toList(),
                        // children: [
                        //   ,
                        //   FavoriteItems1(),
                        //   FavoriteItems1(),
                        //   FavoriteItems1(),
                        //   FavoriteItems1()
                        // ],
                      )
                         ): Center(child: Text("Empty Cart"),);
                                }else{
                                  return Center(
                       child: CircularProgressIndicator(color: Colors.red,),);
                                    }
                                return Center(child: SizedBox(
                                  height: 500,
                                    child: Center(child: Text("Empty Cart"))),);
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

class FavoriteItems1 extends StatefulWidget {
  const FavoriteItems1({Key? key, required this.Img, required this.Place, required this.Name, required this.Price, required this.numItems, required this.Discount, this.Index}) : super(key: key);
  final String Img;
  final String Place;
  final String Name;
  final String Price;
  final int numItems;
  final bool Discount;
  final  Index;

  @override
  _FavoriteItems1State createState() => _FavoriteItems1State();
}

class _FavoriteItems1State extends State<FavoriteItems1> {
  @override
  Widget build(BuildContext context) {
    return Container(
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

                child: Icon(Icons.remove_circle_outlined,color: Colors.red,size: 30,)),
            alignment: Alignment.topRight,
          ),
          Image(image: AssetImage(widget.Img,),width: 130,height: 130,fit: BoxFit.fitWidth,),
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
                    Text(widget.Price,style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.black,
                          padding: EdgeInsets.all(5),
                          child:Center( child:Icon(Icons.shopping_bag,color:Colors.white,size: 25,),),
                        )
                    ),
                  ],
                ),

              ]),

        ],
      ),
    );
  }
}
