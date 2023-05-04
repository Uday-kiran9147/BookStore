
  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/BookProvider.dart';
import '../views/bookdetail_screen.dart';

InkWell bookitem(BuildContext context, BookProvider books, int index) {
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
          // height: 10,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            boxShadow: [BoxShadow(color: Color.fromARGB(255, 55, 51, 51), blurRadius: 3)],
            color: Colors.grey.shade50,
            borderRadius:
                // BorderRadius.all(Radius.circular(10))
                BorderRadius.circular(3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all( 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    height: 150,
                    width: 140,
                    books.booklistgetter[index].coverImageUrl.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                books.booklistgetter[index].title.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.sansita(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 54, 64)),
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
                books.booklistgetter[index].availableFormat.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 211, 105, 111)),
              ),
            ],
          ),
        ),
      ),
    );
  }