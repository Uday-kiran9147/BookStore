import 'package:bookstore/views/bookdetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/BookProvider.dart';
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
      body: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
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
              ? Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: books.booklistgetter.length,
                    itemBuilder: (BuildContext context, int index) {
                      // final book = books[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            BookDetailsScreen.routeName,
                            arguments: books.booklistgetter[index].title,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 3)
                              ],
                              color: Colors.grey.shade50,
                              borderRadius:
                                  // BorderRadius.all(Radius.circular(10))
                                  BorderRadius.circular(3),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(
                                        height: 150,
                                        width: 140,
                                        books
                                            .booklistgetter[index].coverImageUrl
                                            .toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    books.booklistgetter[index].title
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.sansita(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 54, 64)),
                                  ),
                                  Text(
                                    'Author name',
                                    // "\$${books.booklistgetter[index].priceInDollar}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    books.booklistgetter[index].availableFormat
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 211, 105, 111)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(child: Text("No Books Found")),
        ],
      ),
    );
  }
}
