import 'package:flutter/material.dart';

/// Models:

/// Screens:

/// Widgets:

/// Services:

/// State:

/// Utils/Helpers:
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';

/// Entry Point:
class CountryRowWidget extends StatelessWidget {
  const CountryRowWidget({
    required this.placemarks,
  });

  final List<Placemark> placemarks;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (placemarks.isEmpty) {
        return CircularProgressIndicator();
      }
      return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Today",
              // style: GoogleFonts.getFont('Roboto'),
            ),
            Text(
              "${placemarks[0].locality}, ${placemarks[0].country}",
              // style: GoogleFonts.getFont('Roboto'),
            )
          ],
        ),
      );
    });
  }
}
