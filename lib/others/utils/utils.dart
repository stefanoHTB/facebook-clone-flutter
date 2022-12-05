import 'dart:io';

import 'package:facebook_clone/features/reels/widgets/upload_reel_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

////////////////////////////////////////////////////////////////////////

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

///////////////////////////////////////////////////////////////////////

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage
          .path); //here we convert pickedimage to file and store in image var
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

///////////////////////////////////////////////////////////////////////////

pickedVideo(ImageSource src, BuildContext context) async {
  final video = await ImagePicker().pickVideo(source: src);
  if (video != null) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UploadReels(
          videoFile: File(video.path),
          videoPath: video.path,
        ),
      ),
    );
  }
}
