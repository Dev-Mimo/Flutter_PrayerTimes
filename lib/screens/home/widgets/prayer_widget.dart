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
class PrayerWidget extends StatelessWidget {
  const PrayerWidget({
    required this.placemarks,
  });

  final List<Placemark> placemarks;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        if (placemarks.isEmpty) {
          return CircularProgressIndicator();
        }
        return Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://image.freepik.com/free-vector/gradient-mosque-illustration_21745-19.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("Bell"),
                            Text("Mute"),
                          ],
                        ),
                        Text("Next Prayer"),
                        Text("14.24"),
                        Text("3 hours left until Asr"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
