import 'package:facebook_clone/features/auth/controller/auth_controller.dart';
import 'package:facebook_clone/features/auth/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser(
      WidgetRef ref, BuildContext context, String email, String password) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      ref
          .read(authControllerProvider.notifier)
          .loginUser(context, email, password);
    }
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

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
                    const Text('LOGIN'),
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
                          onTap: () => loginUser(ref, context,
                              emailController.text, passwordController.text),
                          child: Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue),
                            child: const Center(
                                child: Text(
                              'LOGIN',
                            )),
                          ),
                        )
                      ],
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: navigateToSignUp,
                        child: const Text('Register'))
                  ],
                ),
              ),
            ),
    );
  }
}
