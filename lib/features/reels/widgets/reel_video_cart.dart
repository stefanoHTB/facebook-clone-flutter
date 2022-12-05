import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/others/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelVideoCart extends StatefulWidget {
  const ReelVideoCart({Key? key}) : super(key: key);

  @override
  State<ReelVideoCart> createState() => _ReelVideoCartState();
}

class _ReelVideoCartState extends State<ReelVideoCart> {
  var reelData = {};
  bool isLoading = false;

  late VideoPlayerController controller;

//////////////////////////////////////////////////////////////////////////////// video controller
  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.network(reelData['videoUrl']);
      controller.initialize();
      controller.play();
      controller.setVolume(1);
      controller.setLooping(true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

//////////////////////////////////////////////////////////////////////////////// get data function

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

////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LinearProgressIndicator()
        : SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 0.48,
                        child: controller == null
                            ? const CircularProgressIndicator()
                            : VideoPlayer(controller))
                  ],
                )
              ],
            ),
          );
  }
}
