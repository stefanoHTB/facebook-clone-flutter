import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/features/reels/screens/video_reels_scree.dart';
import 'package:facebook_clone/others/utils/utils.dart';
import 'package:flutter/material.dart';

class ReelCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;

  const ReelCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<ReelCard> createState() => _ReelCardState();
}

class _ReelCardState extends State<ReelCard> {
  var reelData = {};
  bool isLoading = false;

  getData() async {
    isLoading = true;
    try {
      var postSnap =
          await FirebaseFirestore.instance.collection('reels').doc().get();

      reelData = postSnap.data()!;

      //name = postSnap.data()!['name'];

      setState(() {});
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  ////////////////////////////////////////////////////////////////////////////// Navigate to Screen

  void navigateToVideoReelScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoReelScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToVideoReelScreen,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 230,
                width: 130,
                child: Image.network(
                  widget.snap['thumbnail'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
        // ),
      ),
    );
  }
}
