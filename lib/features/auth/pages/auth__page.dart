import 'package:chirper_client/features/auth/fragments/login__fragment.dart';
import 'package:chirper_client/features/auth/fragments/register__fragment.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int _currentIdx = 0;

  final List content = [
    const LoginFragment(),
    const RegisterFragment(),
  ];

  _navigate(int newIdx) {
    setState(() {
      _currentIdx = newIdx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        content[_currentIdx],
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIdx,
        onTap: _navigate,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.login), label: "Login"),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration), label: "Register"),
        ],
      ),
    );
  }
}
