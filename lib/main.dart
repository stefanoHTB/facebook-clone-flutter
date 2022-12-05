import 'package:facebook_clone/features/auth/controller/auth_controller.dart';
import 'package:facebook_clone/models/user_mode.dart';
import 'package:facebook_clone/routes.dart';
import 'package:facebook_clone/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

//-----------------------------------------------------------------------------

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'facebook tutorial',
              theme: ClassTheme.darkModeAppTheme,
              routeInformationParser: const RoutemasterParser(),
              //----------------------------------------------------------------
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if (userModel != null) {
                    return loggedInRoute;
                  }
                }
                return loggedOutRoute;
              }),
            ),
        //-----------------------------------------------------------------
        error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
        //----------------------------------------------------------------
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
    //----------------------------------------------------------------
  }
}
