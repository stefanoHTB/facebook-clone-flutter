import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/features/reels/widgets/reel_cart.dart';
import 'package:facebook_clone/features/reels/widgets/reel_video_cart.dart';
import 'package:flutter/material.dart';

class VideoReelScreen extends StatefulWidget {
  const VideoReelScreen({Key? key}) : super(key: key);

  @override
  State<VideoReelScreen> createState() => _VideoReelScreenState();
}

class _VideoReelScreenState extends State<VideoReelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('reels')
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
                  return PageView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) => ReelVideoCart(
                          //snap: snapshot.data!.docs[index].data(),
                          )));
                }),
          ),
        ],
      ),
    );
  }
}
