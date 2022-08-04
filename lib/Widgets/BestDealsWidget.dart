import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shoppingapp/BestDealsScreen.dart';

class BestDealsWidget extends StatelessWidget {
  const BestDealsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Container(
        child: Stack(
          children: [
            Container(
              height:180,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(15, 40, 15, 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blueGrey[900],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Container(
                          padding: EdgeInsets.all(10),
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
                      //=================================
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,0,0),
                        child: Text("Best deals on \nFurniture",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:FontWeight.bold,
                            fontSize: 25,
                          ),),
                      ),
                      InkWell(
                        onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>
                               BestDealsScreen() ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Row(
                            children: [
                              Text("Check it out",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              Icon(Icons.arrow_forward,color: Colors.white,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),

            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                child: Image(image: AssetImage("assets/images/chair2.png",
                ),fit:BoxFit.fitWidth,
                  width: 220,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
