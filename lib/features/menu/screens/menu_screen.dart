import 'package:facebook_clone/features/menu/widgets/profile_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Menu',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade800),
                  child: IconButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      icon: const Icon(Icons.logout_outlined))),
              const SizedBox(
                width: 10,
              ),
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade800),
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.add))),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: const [ProfileTile(), Divider()],
      ),
    );
  }
}
