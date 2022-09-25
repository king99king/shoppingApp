import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/SearchScreen.dart';

class searchBar extends StatelessWidget {
  const searchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            searchScreen()));
      },
      child: Container(
        width: 130,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius:BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.search_rounded,
              color: Colors.grey,
              size: 30,
            ),
            Text("Search ... ",
              style: GoogleFonts.tajawal(
                height: 1.8,
                color:Colors.grey,
                fontSize: 20,
              ),),
          ],
        ),
      ),
    );
  }
}
