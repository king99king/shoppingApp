import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/Data/AppData.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fbg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [   IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,size: 40,),

                ),],),
                Center(
                  child: Hero(
                    tag: 'profile',
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueGrey[900],
                        image: DecorationImage(
                          image: AssetImage("assets/images/profile.png")
                        )
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 250,
                      height: 60,

                      decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(child: Text("UserName Name",style:GoogleFonts.tajawal(
                        height: 1.8,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),  overflow: TextOverflow.ellipsis,)),
                    ),
                  ),
                ),
               Text("Email",style: GoogleFonts.tajawal(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontSize: 25,
               ),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("Daivid99@gmail.com",style:GoogleFonts.tajawal(
                      height: 1.8,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),  overflow: TextOverflow.ellipsis,)),
                  ),
                ),
                Text("phone number",style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("99994444",style:GoogleFonts.tajawal(
                      height: 1.8,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),  overflow: TextOverflow.ellipsis,)),
                  ),
                ),
                Text("Location",style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(onPressed: (){}, child: Text("Get Location",style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              // side: BorderSide(color: Colors.red)
                            )
                        ),
                        padding:  MaterialStateProperty.resolveWith((states) =>EdgeInsets.all(22)),
                        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blueGrey[900],)

                    )),
                    Container(
                      width: 220,
                      padding: EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text("Street34-home",style:GoogleFonts.tajawal(
                        height: 1.8,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),  overflow: TextOverflow.ellipsis,
                      maxLines: 1,)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  ElevatedButton(

                    onPressed: (){},
                    child: Center(
                      child: Text("Logout",style:  GoogleFonts.tajawal(fontSize: 20,fontWeight: FontWeight.w600),),
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
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
