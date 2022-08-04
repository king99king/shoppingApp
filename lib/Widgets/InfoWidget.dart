import 'package:flutter/material.dart';
import 'package:shoppingapp/UserInfo.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),

      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Best Furniture For \nYour Room",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoScreen()));
              },
              child: Hero(
                tag: 'profile',
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/profile.png'
                  ),
                  radius: 25,

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
