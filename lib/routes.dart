import 'package:facebook_clone/features/auth/screens/login_screen.dart';
import 'package:facebook_clone/features/bottomTabs/bottom_tabs.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: BottomTabs()),
    //'/create-community': (_) => const MaterialPage(child: CreateCommunityScreen()),
  },
);
