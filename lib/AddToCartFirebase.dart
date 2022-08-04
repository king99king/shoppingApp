import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/Data/AppData.dart';
import 'package:shoppingapp/model/drink_model.dart';

import 'model/cart_model.dart';

void addToCart(GlobalKey<ScaffoldState> scaffoldkey, CardItem cardItem,
    BuildContext context) {
  var cart =
      FirebaseDatabase.instance.ref().child('Cart').child('UNIQUE_USER_ID');
  cart.child(cardItem.key).once().then((event) {
    final dataSnapshot = event.snapshot;
    if (dataSnapshot.value != null) {
      var cartModel =
          CartModel.fromJson(jsonDecode(jsonEncode(dataSnapshot.value)));
      cartModel.quantity += 1;
      cartModel.totalPrice = double.parse(cardItem.Price) * cartModel.quantity;
      cart.child(cardItem.key).set(cartModel.toJson()).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              elevation: 5,
              content: Text(
                "added Successfully ${cartModel.quantity}",
              ))));
    } else {
      CartModel cartModel = new CartModel(
          key: cardItem.key,
          name: cardItem.Name,
          price: cardItem.Price,
          image: cardItem.Img,
          quantity: 1,
          totalPrice: double.parse(cardItem.Price));

      cart.child(cardItem.key).set(cartModel.toJson());
      //.then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // duration: Duration(seconds: 2),
      //  content: Text("something went wrong"))));
    }
  });
}

void updateToCart(GlobalKey<ScaffoldState> scaffoldkey, CartModel cartModel,
    BuildContext context) {
  var cart =
      FirebaseDatabase.instance.ref().child('Cart').child('UNIQUE_USER_ID');
  cart
      .child(cartModel.key)
      .set(cartModel.toJson())
      .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          elevation: 5,
          content: Text(
            "added Successfully",
          ))))
      .catchError((e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          elevation: 5,
          content: Text(
            '$e',
          ))));
}

void deleteCart(GlobalKey<ScaffoldState> scaffoldkey, CartModel cartModel,
    BuildContext context) {
  var cart =
      FirebaseDatabase.instance.ref().child('Cart').child('UNIQUE_USER_ID');
  cart
      .child(cartModel.key)
      .remove()
      .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          elevation: 5,
          content: Text(
            "added Successfully",
          ))))
      .catchError((e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          elevation: 5,
          content: Text(
            '$e',
          ))));
}


void addToFavorite(GlobalKey<ScaffoldState> scaffoldkey, FavoriteItems favoriteItems,
    BuildContext context) {
  var favor =
  FirebaseDatabase.instance.ref().child('Favorite').child('UNIQUE_USER_ID');
  favor.child(favoriteItems.key).once().then((event) {
    final dataSnapshot = event.snapshot;
    if (dataSnapshot.value != null) {
      var FavoriteItem = FavoriteItems.fromJson(jsonDecode(jsonEncode(dataSnapshot.value)));
      favor.child(favoriteItems.key).set(FavoriteItem.toJson()).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          elevation: 5,
          content: Text(
            "added Successfully to favorite",
          ))));
    } else {
      FavoriteItems cartModel = new FavoriteItems(
          key: favoriteItems.key,
          Name: favoriteItems.Name,
          Price: favoriteItems.Price,
          Img: favoriteItems.Img,
           numItemsSold: favoriteItems.numItemsSold,
          Place:favoriteItems.Place,
      );

      favor.child(favoriteItems.key).set(cartModel.toJson());
      //.then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // duration: Duration(seconds: 2),
      //  content: Text("something went wrong"))));
    }
  });
}