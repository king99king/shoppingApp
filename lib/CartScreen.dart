import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                   TextButton(onPressed:() {Navigator.pop(context);}, child: Icon(Icons.arrow_back_rounded,size: 40,color: Colors.black,))
                  ],
                ),
                Text("Items Cart",style: GoogleFonts.tajawal(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),),
                Container(
                  height: 500,
                  child: Expanded(child: ListView(

                    children: [
                      ItemWidget(), ItemWidget(), ItemWidget(), ItemWidget(),
                    ],
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Total items:  ",style: GoogleFonts.tajawal(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                        children: <InlineSpan>[
                          TextSpan(

                              text:"4",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )
                          ),],),),
                    Text.rich(
                      TextSpan(
                        text: "Total Price:  ",style: GoogleFonts.tajawal(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                        children: <InlineSpan>[
                          TextSpan(

                              text:"\$550",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )
                          ),],),),
                  ],
                ),

                ElevatedButton(

                  onPressed: (){},
                  child: Center(
                    child: Text("Proceed to checkout",style: TextStyle(fontSize: 20),),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            // side: BorderSide(color: Colors.red)
                          )
                      ),
                      padding:  MaterialStateProperty.resolveWith((states) =>EdgeInsets.all(22)),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blueGrey[900],)
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ItemWidget extends StatefulWidget {
  const ItemWidget({Key? key}) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  var num=1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
       padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffB9B9B9),
        ),
        child: Row(
          children: [
            Image(image: AssetImage("assets/images/chair.png"),fit: BoxFit.fitWidth,width: 120,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Minimalist Chair",
                style: GoogleFonts.tajawal(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                ),),
                Text.rich(
                  TextSpan(
                    text: "Price:  ",style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                    children: <InlineSpan>[
                      TextSpan(

                          text:"\$120",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )
                      ),],),),
                Row(
                  children: [
                    Text("number of Items:",
                      style: GoogleFonts.tajawal(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          if (num!=1){
                            num=num-1;
                          }

                        });
                      },
                      icon: Icon(Icons.indeterminate_check_box_outlined),
                    ),
                    Text("$num",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          num=num+1;
                        });
                      },
                      icon: Icon(Icons.add_box_outlined),
                    ),
                  ],
                ),
                RichText(
                    text:TextSpan(
                    text: "Color: ",style: GoogleFonts.tajawal(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                    children: [
                      WidgetSpan(child: Container(
                        margin: EdgeInsets.all(5),
                        width: 18,
                       height: 18,
                       decoration: BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.circle,
                       ),

                    ))
                  ]
                )),
                ElevatedButton(onPressed: (){}, child: Center(
                  child: Text("Remove the Item",
                    style: GoogleFonts.tajawal(
                      height: 1.5,
                      fontSize: 18,
                      color: Colors.white,
                    ),),
                ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            // side: BorderSide(color: Colors.red)
                          )
                      ),
                      padding:  MaterialStateProperty.resolveWith((states) =>EdgeInsets.all(8)),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blueGrey[900],)
                  ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
