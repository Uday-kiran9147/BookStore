// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:bookstore/models/bookmodel.dart';

import '../provider/BookProvider.dart';

class CartScreen extends StatefulWidget {
  final int quantity = 1;
  // const CartScreen({
  //   Key? key,
  //   required this.quantity,
  // }) : super(key: key);
  static const routeName = '/cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isloading = false;
  bool isinit = true;
  double total = 0;

  @override
  void didChangeDependencies() {
    final bookstate = Provider.of<BookProvider>(context);

    if (isinit) {
      setState(() {
        isloading = true;
        total = calculateTotalPrice(bookstate.cartListOriginal);
      });

      bookstate.getCartList().then((_) {
        setState(() {
          isloading = false;
        });
      });
    }

    isinit = false;
    super.didChangeDependencies();
  }

  double parseDouble(String s) {
    if (s.runtimeType == String) return double.parse(s);
    return s as double;
  }

  double calculateTotalPrice(List<BookModel> items) {
    double totalPrice = 0;
    for (var i = 0; i < items.length; i++) {
      // var selectedP=  items.contains(items[i]);

      totalPrice += parseDouble(items[i].priceInDollar.toString());
    }
    // print(totalPrice);
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final bookstate = Provider.of<BookProvider>(context);
    // total=0;

    return Scaffold(
      body: FutureBuilder(
        future: bookstate.getCartList(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset('assets/Shopping/back.png'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Bag',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  TextSpan(
                      text:
                          '(${bookstate.cartListOriginal.length * widget.quantity})',
                      style: TextStyle(fontSize: 30 / 2, color: Colors.grey)),
                ])),
              ),
              Expanded(
                  child: bookstate.cartListOriginal.isEmpty
                      ? Center(
                          child: Text("Your Bag is Empty",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        )
                      : ListView.builder(
                          itemCount: bookstate.cartListOriginal.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(
                                          fit: BoxFit.cover,
                                          height: 200,
                                          bookstate.cartListOriginal[index]
                                              .coverImageUrl
                                              .toString()),
                                    ),
                                    title: Text(
                                      bookstate.cartListOriginal[index].title
                                          .toString(),
                                      maxLines: 2,
                                    ),
                                    subtitle: Text(
                                      '\$${bookstate.cartListOriginal[index].priceInDollar}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          color: Colors.red.shade400),
                                    ),
                                    trailing: Text(
                                        '\$${bookstate.cartListOriginal[index].priceInDollar}'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('Qty ${widget.quantity}'),
                                      IconButton(
                                        onPressed: () {
                                          bookstate.removefromCart(index);
                                          setState(() {
                                            total = calculateTotalPrice(
                                                bookstate.cartListOriginal);
                                          });
                                          bookstate.storeCartList(
                                              bookstate.cartListOriginal);
                                        },
                                        icon: Icon(Icons.delete),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }))
            ],
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Subtotal: ${(total * widget.quantity).toStringAsFixed(2)}",
            style: GoogleFonts.poppins(
              fontSize: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(30)),
              height: 70,
              child: Center(
                  child: InkWell(
                onTap: () {
                  if (bookstate.cartListOriginal.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.green,
                        content: Text("Your Order Confirmed...")));
                  }
                  setState(() {
                    bookstate.cartListOriginal.clear();
                    bookstate.storeCartList(bookstate.cartListOriginal);
                  });
                },
                child: Text('Proceed to Checkout',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.white,
                    )),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
