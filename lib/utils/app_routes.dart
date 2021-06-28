import 'package:flutter/material.dart';

/// Models:

/// Screens:
import 'package:adhan_app/screens/home/home_screen.dart';

/// Widgets:

/// Services:

/// State:

/// Utils/Helpers:
import 'package:beamer/beamer.dart';

/// Entry Point:
final appRoutes = SimpleLocationBuilder(
  routes: {
    '/': (context, state) => BeamPage(
      key: ValueKey('Home'),
      child: HomeScreen()
    ),
  },
);
