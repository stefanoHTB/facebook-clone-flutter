import 'package:facebook_clone/features/home/screens/together_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  static const String routeName = '/feed';

  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //----------------------------------------------------------- NAVBAR HOME
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'facebook',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          actions: [
            Row(
              children: [
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
        drawer: Drawer(
          child: ListView(),
        ),
        //-------------------------------------------------- BODY HOME (TOGETHER SCREEN)
        body: const SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: TogetherScreen(),
        ));
  }
}
