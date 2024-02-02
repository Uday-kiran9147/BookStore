import 'package:flutter/material.dart';
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
      appBar: AppBar(elevation: 5,actions: [SizedBox(width: 40,child: Icon(Icons.search)),SizedBox(width: 40,child: Icon(Icons.notification_add))],
        backgroundColor: Colors.red.shade400,
        title: Text("PICKWICK BOOKS"),
        // centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  height: 90,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      hintText: 'Search',
                      fillColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen())),
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
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 3/ 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
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
