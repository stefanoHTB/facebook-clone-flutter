import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/features/post/screens/post_screen.dart';
import 'package:facebook_clone/others/utils/utils.dart';
import 'package:facebook_clone/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WhatsOnYourMind extends StatefulWidget {
  final String uid;
  const WhatsOnYourMind({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<WhatsOnYourMind> createState() => _WhatsOnYourMindState();
}

class _WhatsOnYourMindState extends State<WhatsOnYourMind> {
  void navigateToPostScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            PostScreen(uid: FirebaseAuth.instance.currentUser!.uid),
      ),
    );
  }

  var userData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    isLoading = true;
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: ClassTheme.drawerColor),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CircleAvatar(
                        radius: 23.0,
                        backgroundImage: NetworkImage(userData['profilePic']),
                      ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: navigateToPostScreen,
                    child: const Text(
                      "What's on your mind?                          ",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ))
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.insert_photo,
                  color: Colors.green,
                ))
          ],
        ),
      ),
    );
  }
}
