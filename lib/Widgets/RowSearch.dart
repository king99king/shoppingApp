import 'package:flutter/material.dart';
import 'package:shoppingapp/Widgets/Extended/CartWidget.dart';
import 'package:shoppingapp/Widgets/Extended/FavoriteWidget.dart';
import 'package:shoppingapp/Widgets/Extended/SearchBar.dart';

class RowSearch extends StatelessWidget {
  const RowSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(

            child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              searchBar(),
              CartWidget(),
              FavoriteWidget(),
            ],
          ),)

    );
  }
}
