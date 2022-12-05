import 'package:facebook_clone/others/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestScreen3 extends StatefulWidget {
  const TestScreen3({Key? key}) : super(key: key);

  @override
  State<TestScreen3> createState() => _TestScreen3State();
}

class _TestScreen3State extends State<TestScreen3> {
  final ImagePicker _picker = ImagePicker();

  // pickImage() {
  //   try {
  //     _picker.pickImage(source: ImageSource.gallery);
  //   } catch (e) {
  //     showSnackBar(context: context, content: e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () => pickImageFromGallery(context),
              child: Text('Image picker'))
        ],
      ),
    );
  }
}
