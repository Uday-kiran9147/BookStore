import 'package:bookstore/provider/BookProvider.dart';
import 'package:bookstore/views/cart_screen.dart';
import 'package:bookstore/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/bookdetail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookProvider>(
          create: (context) => BookProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Book Store ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Colors.,
          primaryColor: Colors.white,
        ),
        home: SafeArea(child: BookListScreen()),
        routes: {
          BookDetailsScreen.routeName: (context) => BookDetailsScreen(),
          CartScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}
