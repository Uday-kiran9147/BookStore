import 'dart:convert';

import 'package:bookstore/data/jsondata.dart';
import 'package:bookstore/models/bookmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookProvider with ChangeNotifier {
  
  void removefromCart(int index) {
    cartlist.removeAt(index);
    notifyListeners();
  }

  List<BookModel> search_book(String searchQuery) {
    return booklistgetter
        .where((element) => element.title
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> storeCartList(List<BookModel> cartList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartListJson =
        cartList.map((cart) => cart.toJson()).toList(growable: true);
    await prefs.setString('cartlist', (jsonEncode(cartListJson)));
    notifyListeners();
  }

  Future<List<BookModel>> getCartList() async {
    cartlist.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartListJson = prefs.getString('cartlist');
    if (cartListJson == null) {
      return [];
    }
    List cartListDecoded = json.decode(cartListJson);
    // print(cartListDecoded.toString());
    List<BookModel> cart =
        cartListDecoded.map((e) => BookModel.fromJson(e)).toList();
    cartlist.addAll(cart);
    return cart;
  }

  final List<BookModel> booklist = [];
  void addtoCart(BookModel book) {
    cartlist.add(book);
    notifyListeners();
  }

  getdata() {
    booklist.clear();
    var parseddata = jsondata
        .map((e) => BookModel(
            title: e['title'],
            coverImageUrl: e['cover_image_url'],
            priceInDollar: e['price_in_dollar'].toString(),
            categories: e['categories'],
            availableFormat: e['available_format']))
        .toList();

    booklist.addAll(parseddata);
  }

  List<BookModel> cartlist = [];
  List<BookModel> get cartlistgetter => [...cartlist];
  List<BookModel> get booklistgetter => [...booklist];
}
