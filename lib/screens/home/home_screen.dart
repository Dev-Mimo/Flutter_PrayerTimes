import 'package:flutter/material.dart';

/// Models:

/// Screens:

/// Widgets:
import 'package:adhan_app/screens/home/widgets/country_row_widget.dart';
import 'package:adhan_app/screens/home/widgets/prayer_widget.dart';

/// Services:

/// State:

/// Utils/Helpers:
import 'package:adhan_app/utils/responsive_helper.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';

/// Entry Point:
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final location = new loc.Location();
  String? locationError;
  PrayerTimes? prayerTimes;
  List<Placemark> placemarks = [];

  @override
  void didChangeDependencies() async {
    final locationData = await getLocationData();
    if (locationData != null) {
      print(locationData);

      placemarks = await placemarkFromCoordinates(
          locationData.latitude as double, locationData.longitude as double,
          localeIdentifier: "en_US");

      print(placemarks);

      setState(() {
        prayerTimes = PrayerTimes(
            Coordinates(locationData.latitude as double, locationData.longitude as double),
            DateComponents.from(DateTime.now()),
            CalculationMethod.karachi.getParameters());
      });
    } else {
      setState(() {
        locationError = "Couldn't Get Your Location!";
      });
    }
    super.didChangeDependencies();
  }

  Future<loc.LocationData?> getInitStateLocationData() async {
    final locationData = await getLocationData();
    return locationData;
  }

  Future<loc.LocationData?> getLocationData() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    // print("MediaQuery size = $_size");
    // print("Window size = ${window.physicalSize}");

    return Scaffold(
      body: SafeArea(
        child: ResponsiveHelper(
          mobile: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      // Builder(
                      //   builder: (BuildContext context) {
                      //     if (prayerTimes != null) {
                      //       return Column(
                      //         children: [
                      //           Text(
                      //             'Prayer Times for Today',
                      //             textAlign: TextAlign.center,
                      //           ),
                      //           Text('Fajr Time: ' + DateFormat.jm().format(prayerTimes!.fajr)),
                      //           Text('Sunrise Time: ' +
                      //               DateFormat.jm().format(prayerTimes!.sunrise)),
                      //           Text('Dhuhr Time: ' + DateFormat.jm().format(prayerTimes!.dhuhr)),
                      //           Text('Asr Time: ' + DateFormat.jm().format(prayerTimes!.asr)),
                      //           Text('Maghrib Time: ' +
                      //               DateFormat.jm().format(prayerTimes!.maghrib)),
                      //           Text('Isha Time: ' + DateFormat.jm().format(prayerTimes!.isha)),
                      //         ],
                      //       );
                      //     }
                      //     if (locationError != null) {
                      //       return Text(locationError!);
                      //     }
                      //     return Text('Waiting for Your Location...');
                      //   },
                      // )
                      Expanded(
                        flex: 1,
                        // Country-row widget:
                        child: CountryRowWidget(placemarks: placemarks),
                      ),
                      Expanded(
                        flex: 6,
                        child: PrayerWidget(placemarks: placemarks),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          tablet: Column(
            children: [],
          ),
          desktop: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}