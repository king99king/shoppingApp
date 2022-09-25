import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/Widgets/BestDealsWidget.dart';
import 'package:shoppingapp/Widgets/BestSellerWidget.dart';
import 'package:shoppingapp/Widgets/CategoryList.dart';
import 'package:shoppingapp/Widgets/InfoWidget.dart';
import 'package:shoppingapp/Widgets/RowSearch.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  StreamSubscription? connection;
  bool isoffline = false;
  @override
  void initState() {
    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.ethernet){
        //connection is from wired connection
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.bluetooth){
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
        });
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldkey,
      backgroundColor:  Colors.white,
        body:SafeArea(
      child:   isoffline? Center(child:
      Text("You are offline, \n Please connect your phone",style: TextStyle(
        fontSize: 30,

      ),
        textAlign: TextAlign.center,),):Container(
          child: ListView(
            children: [
              InfoWidget(),
              RowSearch(),
              BestDealsWidget(),
              CategoryList(),
              BestSellerWidget(),

            ],
          ),
        ),
      ),
    );
  }
}
