import 'dart:io';

import 'package:facebook_clone/features/auth/controller/auth_controller.dart';
import 'package:facebook_clone/features/bottomTabs/bottom_tabs.dart';
import 'package:facebook_clone/others/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';

  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    lastNameController.dispose();
  }

  //---------------------------------------------

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  //--------------------------------------------

  void saveUserData(
    WidgetRef ref,
    BuildContext context,
    String name,
    String lastName,
  ) {
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();

    if (name.isNotEmpty && lastName.isNotEmpty) {
      ref
          .read(authControllerProvider.notifier)
          .saveUserDataToFirebase(context, name, lastName, image);
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const BottomTabs()));
  }
  //---------------------------------------------

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      image == null
                          ? const CircleAvatar(
                              radius: 64.0,
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                            )
                          : CircleAvatar(
                              radius: 64.0,
                              backgroundImage: FileImage(
                                image!,
                              )),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 350,
                        //size.width * 0.85,
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              hintText: 'Enter your name'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 350,
                        //size.width * 0.85,
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: lastNameController,
                          decoration: const InputDecoration(
                              hintText: 'Enter your last name'),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => saveUserData(ref, context, nameController.text,
                        lastNameController.text),
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: const Center(
                          child: Text(
                        'Submit',
                      )),
                    ),
                  )
                ],
              ),
            )),
    );
  }
}
