import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/features/reels/widgets/reel_cart.dart';
import 'package:facebook_clone/others/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade500,
        onPressed: () => pickedVideo(ImageSource.gallery, context),
        child: const Icon(Icons.video_camera_back),
      ),
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
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) => ReelCard(
                            snap: snapshot.data!.docs[index].data(),
                          )));
                }),
          ),
        ],
      ),
    );
  }
}
