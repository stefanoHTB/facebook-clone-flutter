import 'package:facebook_clone/features/profile/widgets/profile_banner.dart';
import 'package:facebook_clone/others/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Column(
        children: const [
          ProfileandBanner(),
        ],
      ),
    );
  }
}
