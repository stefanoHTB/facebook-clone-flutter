import 'package:facebook_clone/features/auth/screens/user_information_screen.dart';
import 'package:facebook_clone/features/home/screens/feed_screen.dart';
import 'package:facebook_clone/others/widgets/error_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const UserInformationScreen());
    case FeedScreen.routeName:
      return MaterialPageRoute(builder: (context) => const FeedScreen());

    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: ErrorScreen(error: 'This page does not exist'),
              ));
  }
}
