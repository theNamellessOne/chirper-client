import 'package:chirper_client/features/auth/services/auth__service.dart';
import 'package:chirper_client/fragments/button__fragment.dart';
import 'package:chirper_client/fragments/input__fragment.dart';
import 'package:chirper_client/storage/storage.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class LoginFragment extends StatefulWidget {
  const LoginFragment({super.key});

  @override
  State<LoginFragment> createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  String errMsg = "";
  bool isLoading = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Login",
            style: TextStyle(fontSize: 28),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              InputFragment(
                icon: Icons.person,
                hintText: "username",
                isDisabled: isLoading,
                controller: usernameController,
              ),
              const SizedBox(height: 10),
              InputFragment(
                icon: Icons.lock,
                isPassword: true,
                isDisabled: isLoading,
                hintText: "password",
                controller: passwordController,
              ),
              const SizedBox(
                height: 5,
              ),
              (errMsg.isNotEmpty
                  ? Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                errMsg,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    )),
              const SizedBox(
                height: 5,
              ),
              ButtonFragment(
                isDisabled: isLoading,
                onClick: handleLoginButtonPress,
                child: const Text("Login"),
              )
            ],
          ),
        ],
      ),
    );
  }

  void handleLoginButtonPress() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = await AuthService()
          .authorize(usernameController.text, passwordController.text);

      Storage.write("username", user!.username);
      Storage.write("password", user!.password);
    } catch (e) {
      setState(() {
        errMsg = "fuck you";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
