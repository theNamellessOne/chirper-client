import 'package:chirper_client/fragments/button__fragment.dart';
import 'package:chirper_client/fragments/input__fragment.dart';
import 'package:flutter/material.dart';

import '../../../storage/storage.dart';
import '../model/user.dart';
import '../services/auth__service.dart';

class RegisterFragment extends StatefulWidget {
  const RegisterFragment({super.key});

  @override
  State<RegisterFragment> createState() => _RegisterFragmentState();
}

class _RegisterFragmentState extends State<RegisterFragment> {
  String errMsg = "";
  bool isLoading = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Register",
            style: TextStyle(fontSize: 28),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              InputFragment(
                icon: Icons.person,
                isDisabled: isLoading,
                hintText: "username",
                controller: usernameController,
              ),
              const SizedBox(height: 10),
              InputFragment(
                icon: Icons.text_fields,
                isDisabled: isLoading,
                hintText: "first name",
                controller: firstNameController,
              ),
              const SizedBox(height: 10),
              InputFragment(
                icon: Icons.text_fields,
                isDisabled: isLoading,
                hintText: "last name",
                controller: lastNameController,
              ),
              const SizedBox(height: 10),
              InputFragment(
                icon: Icons.lock,
                isPassword: true,
                isDisabled: isLoading,
                hintText: "password",
                controller: passwordController,
              ),
              const SizedBox(height: 5),
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
              const SizedBox(height: 5),
              ButtonFragment(
                  isDisabled: isLoading,
                  onClick: handleRegisterButtonPress,
                  child: const Text("register"))
            ],
          ),
        ],
      ),
    );
  }

  void handleRegisterButtonPress() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = await AuthService().register(
        usernameController.text,
        passwordController.text,
        lastNameController.text,
        firstNameController.text,
      );

      Storage.write("username", user!.username);
      Storage.write("password", user!.password);
    } catch (e) {
      setState(() {
        errMsg = "poshel naxui";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
