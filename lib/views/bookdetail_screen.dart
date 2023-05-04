import 'package:bookstore/views/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/BookProvider.dart';

class BookDetailsScreen extends StatefulWidget {
  static const routeName = '/book-detailscreen';

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  int _guests = 0;
  @override
  Widget build(BuildContext context) {
    final booktitle = ModalRoute.of(context)!.settings.arguments;
    final bookstate = Provider.of<BookProvider>(context);
    final selectedbook = bookstate.booklistgetter.firstWhere(
      (element) => element.title == booktitle,
    );
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 70.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset('assets/Shopping/back.png'),
                ),
              ),
              InkWell(
                onTap: () async {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset('assets/Shopping/bag.png'),
                ),
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      borderOnForeground: true,
                      elevation: 5,
                      // height: 300.0,
                      // decoration: BoxDecoration(
                      //   // borderRadius: BorderRadius.circular(10.0),
                      //   borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Colors.black54,
                      //       offset: Offset(5, 3.0),
                      //       blurRadius: 15.0,
                      //     ),
                      //   ],
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Image.network(
                          fit: BoxFit.fill,
                          selectedbook.coverImageUrl.toString(),
                          height: 200.0,
                          // width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  Center(
                      child: Column(
                    children: [
                      SizedBox(height: 16.0),
                      Text(
                        selectedbook.title.toString(),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Author\n\nprice : \$${selectedbook.priceInDollar}",
                        style: TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "${selectedbook.title} + Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque quis est interdum, convallis ligula non, tristique leo. Aliquam porta nisl id cursus rutrum. Curabitur eros lorem, fringilla quis augue ut, porttitor elementum diam. Nulla facilisi. Quisque lacus enim, placerat at tortor rhoncus, consectetur finibus ipsum. Lorem ipsum dolor .",
                          style: TextStyle(fontSize: 18.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              height: 70,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.red.shade400)),
                onPressed: () async {
                  // Add book to cart
                  // bookstate.cartlist.clear();

                  bookstate.addtoCart(selectedbook);
                  await bookstate.storeCartList(bookstate.cartlist);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Row(
                      children: [
                        IconButton(
                          focusColor: Theme.of(context).primaryColor,
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (_guests > 0) {
                                _guests--;
                              }
                            });
                          },
                        ),
                        Text('$_guests'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              if (_guests < 5) {
                                _guests++;
                              }
                            });
                            if (_guests >= 5) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.purpleAccent,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                        'maximun no.of books Reached',
                                      )));
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
