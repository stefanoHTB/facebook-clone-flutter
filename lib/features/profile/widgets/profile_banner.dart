import 'package:facebook_clone/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileandBanner extends ConsumerWidget {
  const ProfileandBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return SizedBox(
      height: 340,
      child: Stack(
        children: [
          Image.network(
            'https://cdn.pixabay.com/photo/2018/01/25/14/12/nature-3106213_960_720.jpg',
            width: double.infinity,
            height: 280,
          ),
          Positioned(
            top: 120,
            left: 10,
            child: ClipOval(
              child: Image.network(
                user.profilePic,
                //Constants.avatarDefault,
                fit: BoxFit.fill,
                height: 190,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(user.name)
        ],
      ),
    );
  }
}
