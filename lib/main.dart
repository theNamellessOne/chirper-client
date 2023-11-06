import 'package:chirper_client/features/auth/pages/auth__page.dart';
import 'package:chirper_client/features/feed/pages/feed__page.dart';
import 'package:chirper_client/storage/storage.dart';
import 'package:flutter/material.dart';

import 'features/auth/model/user.dart';
import 'features/auth/services/auth__service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuth = false;
  bool isLoading = true;

  checkAuth() async {
    final username = await Storage.read("username");
    final password = await Storage.read("password");

    User? user;
    if (username is String && password is String) {
      user = await AuthService().authorize(username, password);
    }


    setState(() {
      isAuth = user is User;
      isLoading = false;
    });
  }

  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: isLoading
          ? const SizedBox()
          : isAuth
          ? const FeedPage()
          : const AuthPage(),
    );
  }
}
