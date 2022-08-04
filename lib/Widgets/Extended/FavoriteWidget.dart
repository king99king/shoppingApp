
import 'package:flutter/material.dart';
import 'package:shoppingapp/FavoriteScreen.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            FavoriteScreen()));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration:BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius: BorderRadius.circular(10),

        ),
        child: Icon(
           Icons.favorite,
          color: Colors.red,
          size: 30,
        ),
      ),
    );
  }
}
