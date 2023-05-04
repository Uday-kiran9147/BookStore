// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/BookProvider.dart';
import '../views/bookdetail_screen.dart';

class BookItem extends StatelessWidget {
  String? title;
  String? coverImageUrl;
  String? priceInDollar;
  List<String>? categories;
  List<String>? availableFormat;

  BookItem({
    Key? key,
    required this.title,
    required this.coverImageUrl,
    required this.priceInDollar,
    required this.categories,
    required this.availableFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<BookProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          BookDetailsScreen.routeName,
          arguments: title,
        );
      },
      child: Container(
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      height: 150,
                      width: 140,
                      coverImageUrl.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  title.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "\$${priceInDollar}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  availableFormat.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          )),
    );
  }
}
