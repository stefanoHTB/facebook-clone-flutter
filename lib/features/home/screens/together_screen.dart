import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/features/home/widgets/post_cart.dart';
import 'package:facebook_clone/others/widgets/tab_bars.dart';
import 'package:facebook_clone/others/widgets/whats_on_your_mind_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TogetherScreen extends StatelessWidget {
  const TogetherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            WhatsOnYourMind(uid: FirebaseAuth.instance.currentUser!.uid),
            const SizedBox(
              height: 10,
            ),
            const TabBars(),

            SizedBox(
              height: 790,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .orderBy('datePublished', descending: true)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) => PostCart(
                              snap: snapshot.data!.docs[index].data(),
                            )));
                  }),
            ),
            // )
          ],
        ),
      ),
    );
  }
}
