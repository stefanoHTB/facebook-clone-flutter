import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/features/home/screens/feed_screen.dart';
import 'package:facebook_clone/features/reels/repository/reels_respository.dart';
import 'package:facebook_clone/others/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class UploadReels extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const UploadReels(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<UploadReels> createState() => _UploadReelsState();
}

class _UploadReelsState extends State<UploadReels> {
  late VideoPlayerController controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
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

  /////////////////////////////////////////////////////////////////////////

  uploadReel() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await ReelsRepository(
              auth: FirebaseAuth.instance,
              storage: FirebaseStorage.instance,
              firestore: FirebaseFirestore.instance)
          .uploadVideo(
        widget.videoPath,
        context,
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FeedScreen(),
        ),
      );
      showSnackBar(context: context, content: 'Posted');
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const LinearProgressIndicator()
          : SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 0.48,
                    child: VideoPlayer(controller),
                  ),
                  Positioned(
                      left: 300,
                      top: 780,
                      child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.black,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade900,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 4,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade700,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'Share',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(),
                                            onPressed: uploadReel,
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 150.0,
                                                  vertical: 15),
                                              child: Text('Share'),
                                            ))
                                      ],
                                    ),
                                  );
                                });
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Next',
                              style: TextStyle(color: Colors.black),
                            ),
                          )))
                ])
              ]),
            ),
    );
  }
}
