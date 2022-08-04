import 'package:flutter/material.dart';
import 'package:shoppingapp/Widgets/BestDealsWidget.dart';
import 'package:shoppingapp/Widgets/BestSellerWidget.dart';
import 'package:shoppingapp/Widgets/CategoryList.dart';
import 'package:shoppingapp/Widgets/InfoWidget.dart';
import 'package:shoppingapp/Widgets/RowSearch.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:  Colors.white,
        body:SafeArea(
      child: Container(
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
