import 'package:facebook_clone/features/auth/controller/auth_controller.dart';
import 'package:facebook_clone/features/auth/screens/login_screen.dart';
import 'package:facebook_clone/features/auth/screens/user_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  //------------------------------------------------------------------------
  void registerUser(
      WidgetRef ref, BuildContext context, String email, String password) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      ref
          .read(authControllerProvider.notifier)
          .registerUser(context, email, password);
    }

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const UserInformationScreen()));
  }

  //-------------------------------------------------------------------------

  void navigateToLoginScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  //-------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    const Text('REGISTER HERE'),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                            controller: emailController,
                            decoration:
                                const InputDecoration(hintText: 'email')),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: passwordController,
                            decoration:
                                const InputDecoration(hintText: 'password')),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () => registerUser(ref, context,
                              emailController.text, passwordController.text),
                          child: Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red),
                            child: const Center(
                                child: Text(
                              'Sign up',
                            )),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: navigateToLoginScreen,
                        child: const Text('LOGIN'))
                  ],
                ),
              ),
            ),
    );
  }
}
