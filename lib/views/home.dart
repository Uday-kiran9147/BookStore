import 'package:bookstore/views/bookdetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/BookProvider.dart';
import '../widgets/book_item.dart';
import 'cart_screen.dart';

class BookListScreen extends StatefulWidget {
  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  String searchQuery = "";
  @override
  void initState() {
    final bookstate = Provider.of<BookProvider>(context, listen: false);
    bookstate.getdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<BookProvider>(context);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 90,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, CartScreen.routeName),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset('assets/Shopping/bag.png'),
                  ),
                )
              ],
            ),
          ),
          (books.search_book(searchQuery).length > 0)
              ? GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 3 / 5.5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: books.booklistgetter.length,
                itemBuilder: (BuildContext context, int index) {
                  // final book = books[index];
                  return bookitem(context, books, index);
                },
              )
              : Center(child: Text("No Books Found!!")),
        ],
      ),
    );
  }

}
