import 'package:facebook_clone/features/profile/screens/profile_screen.dart';
import 'package:facebook_clone/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatefulWidget {
  const ProfileTile({Key? key}) : super(key: key);

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  bool isLoading = false;

  void navigateToProfileScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProfileScreen()

          //PostScreen(uid: FirebaseAuth.instance.currentUser!.uid),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToProfileScreen,
      child: Container(
        decoration: const BoxDecoration(color: ClassTheme.drawerColor),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Row(
                children: [
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const CircleAvatar(
                          radius: 23.0,
                          backgroundImage: NetworkImage(
                              'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2'),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      const Text('name and lastanme'),
                      const Text('See your profile')
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
