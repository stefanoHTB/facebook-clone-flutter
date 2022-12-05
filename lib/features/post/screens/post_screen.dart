import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/features/home/screens/feed_screen.dart';
import 'package:facebook_clone/features/post/repository/post_respository.dart';
import 'package:facebook_clone/others/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  final String uid;

  const PostScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  File? image;
  bool _isLoading = false;
  var userData = {};

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

//----------------------------------------------------------------
  void postScreen(
    String uid,
    String name,
    String lastName,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await PostRepository(firestore: FirebaseFirestore.instance).uploadPost(
          context,
          _descriptionController.text,
          image,
          uid,
          name,
          lastName,
          profImage);

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
  //----------------------------------------------------

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  //-------------------------------------------- GET DATA FUNC (DELETE)

  getData() async {
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
  }

////////////////////////////////////////////////////////////////////// UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade800,
        onPressed: selectImage,
        child: IconButton(
            onPressed: selectImage,
            icon: const Icon(
              Icons.insert_photo,
              color: Colors.green,
            )),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () => postScreen(userData['uid'], userData['name'],
                    userData['lastName'], userData['profilePic']),
                child: const Text(
                  'POST',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          const SizedBox(
            width: 5,
          )
        ],
        centerTitle: true,
        title: const Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? const LinearProgressIndicator()
            : Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 350,
                        //size.width * 0.85,
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                              hintText: "What's on your mind?"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ///////////////////////////////////////////////////////////////////////
                  image == null
                      ? const Text(
                          '',
                          style: TextStyle(color: Colors.black),
                        )
                      : SizedBox(
                          height: 505,
                          width: 505,
                          child:
                              // AspectRatio(
                              //   aspectRatio: 487 / 451,
                              //   child:
                              Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(image!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
