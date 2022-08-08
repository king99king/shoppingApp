import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/Data/AppData.dart';
import 'package:shoppingapp/refrancePages/model/cart_model.dart';


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

void updateToCart(GlobalKey<ScaffoldState> scaffoldkey, CartItem cartItem,
    BuildContext context) {
  var cart =
      FirebaseDatabase.instance.ref().child('Cart').child('UNIQUE_USER_ID');
  cart
      .child(cartItem.key)
      .set(cartItem.toJson())
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

void deleteCart(GlobalKey<ScaffoldState> scaffoldkey, CartItem cartItem,
    BuildContext context) {
  var cart =
      FirebaseDatabase.instance.ref().child('Cart').child('UNIQUE_USER_ID');
  cart
      .child(cartItem.key)
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


void addToFavorite(GlobalKey<ScaffoldState> scaffoldkey, CardItem cardItem,
    BuildContext context) {
  var favorite =
  FirebaseDatabase.instance.ref().child('Favorite').child('UNIQUE_USER_ID');
  favorite.child(cardItem.key).once().then((event) {
    final dataSnapshot = event.snapshot;
    if (dataSnapshot.value != null) {
      var favoriteModel =
      FavoriteItems.fromJson(jsonDecode(jsonEncode(dataSnapshot.value)));
    //  favoriteModel.quantity += 1;
     // favoriteModel.totalPrice = double.parse(cardItem.Price) * favoriteModel.quantity;
      favorite.child(cardItem.key).set(favoriteModel.toJson()).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          elevation: 5,
          content: Text(
            "${favoriteModel.Name} added Successfully to favorite ",
          ))));
    } else {
      FavoriteItems favoriteItems = new FavoriteItems(
          key: cardItem.key,
          Name: cardItem.Name,
          Price: cardItem.Price,
          Img: cardItem.Img,
        Place: cardItem.Place,
         Detailes: cardItem.Detailes,
         // quantity: 1,
        //  totalPrice: double.parse(cardItem.Price)
          );

      favorite.child(cardItem.key).set(favoriteItems.toJson());
      //.then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // duration: Duration(seconds: 2),
      //  content: Text("something went wrong"))));
    }
  });
}


void deleteFromFavorite(GlobalKey<ScaffoldState> scaffoldkey, FavoriteItems cartModel,
    BuildContext context) {
  var favorite =
  FirebaseDatabase.instance.ref().child('Favorite').child('UNIQUE_USER_ID');
  favorite.child(cartModel.key).remove()
      .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      elevation: 5,
      content: Text(
        "removed Successfully",
      ))))
      .catchError((e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      elevation: 5,
      content: Text(
        '$e',
      ))));}

void addToCartFromFavorite(GlobalKey<ScaffoldState> scaffoldkey, FavoriteItems cardItem,
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