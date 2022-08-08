
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/CategoryDetailsScreen.dart';
import 'package:shoppingapp/Data/AppData.dart';


class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<CategoryListLis> categoryModels = List<CategoryListLis>.empty(growable: true);
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(
              height: 140,
              child: Flex(
                direction: Axis.vertical,
                children:[ Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Categories",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),),
                          StreamBuilder(
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
                                 return Expanded(
                                    child: Container(
                                      child: ListView.builder(
                                        itemCount: categoryModels.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.all(10),
                                        itemBuilder: (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: (){
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => CategoryDetailsScreen(Cat1: categoryModels[index],)));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                // color:(index==0) ? Colors.yellowAccent[700] :  Colors.blueGrey[50],
                                                color: Colors.blueGrey[100],
                                              ),
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  //Image(image: AssetImage(tx.img),width: 60,),
                                                  Text(
                                                    '${categoryModels[index].name}',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                ],
                                              ),
                                            ),

                                          );


                                      },

                                      ),
                                    ),
                                  );
                                  }else
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                    );
                            },
                          ),
                        ] ),
                  ),
                )],
              ),
            ),

          )
        ]
    );
  }
}
