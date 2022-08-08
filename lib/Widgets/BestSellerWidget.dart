import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/AddToCartFirebase.dart';
import 'package:shoppingapp/Data/AppData.dart';
import 'package:shoppingapp/DetailsScreen.dart';


class BestSellerWidget extends StatefulWidget {
  const BestSellerWidget({Key? key}) : super(key: key);

  @override
  State<BestSellerWidget> createState() => _BestSellerWidgetState();
}

class _BestSellerWidgetState extends State<BestSellerWidget> {
  List<CardItem> itemsModels = List<CardItem>.empty(growable: true);
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(5.0),
      child: Expanded(
        child: Column(
            children:<Widget> [
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Best Seller',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            InkWell(
              onTap: (){},
              child:Text("View all" , style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),) ,)
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.all(1),
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
                  child: Container(
                    height: 390,
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(15),
                        scrollDirection: Axis.horizontal,
                        itemCount: itemsModels.length,
                        itemBuilder:(BuildContext context, int index){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>DetailsScreen(
                                  Item:itemsModels[index],
                                ),),);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[100],
                                  borderRadius: BorderRadius.circular(10)
                              ),

                              child: Column(
                                children: [

                                  Hero(
                                      tag:'item',
                                      child: Image(image: AssetImage('${itemsModels[index].Img}',),width: 190,height: 190,)),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[

                                        Text(
                                                '${itemsModels[index].Place}',style: TextStyle(
                                          color: Colors.grey[900],
                                          fontSize: 16,

                                        ),),
                                        Text(
                                                '${itemsModels[index].Name}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),),
                                        Row(
                                          children: [Icon(Icons.star,color: Colors.yellow[600],),
                                            Icon(Icons.star,color: Colors.yellow[600],),Icon(Icons.star,color: Colors.yellow[600],),
                                            Icon(Icons.star,color: Colors.yellow[600],),Icon(Icons.star,color: Colors.yellow[600],),
                                          ],
                                        ),]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                              '\$${itemsModels[index].Price}',style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(width: 70,),
                                      InkWell(
                                        onTap: (){
                                          addToCart(_scaffoldkey, itemsModels[index], context);
                                        },
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Container(
                                              color: Colors.black,
                                              padding: EdgeInsets.all(16),
                                              child:Center( child:Icon(Icons.shopping_bag,color:Colors.white,size: 30,),),
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                );
                }else
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );


                }



        ),
      ),
            ],
        ),

      ),
    );




  }
}
