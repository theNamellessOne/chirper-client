import 'package:flutter/material.dart';

class InputFragment extends StatefulWidget {
  const InputFragment(
      {super.key,
      this.icon,
      this.hintText,
      this.controller,
      this.isPassword = false,
      this.isDisabled = false});

  final TextEditingController? controller;
  final IconData? icon;
  final String? hintText;
  final bool isPassword;
  final bool isDisabled;

  @override
  State<InputFragment> createState() => _InputFragmentState(this.isPassword);
}

class _InputFragmentState extends State<InputFragment> {
  late bool showPassword;

  _InputFragmentState(bool isPassword) {
    showPassword = isPassword;
  }

  toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.blueAccent)),
      child: TextField(
        enabled: !widget.isDisabled,
        controller: widget.controller,
        obscureText: showPassword,
        autocorrect: !showPassword,
        enableSuggestions: !showPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          prefixIconColor: Colors.blueAccent,
          suffixIcon: (widget.isPassword
              ? IconButton(
                  icon: Icon((showPassword
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded)),
                  onPressed: () {
                    setState(() {
                      toggleShowPassword();
                    });
                  },
                )
              : null),
          suffixIconColor: Colors.blueAccent,
          contentPadding: const EdgeInsets.all(10),
          border: InputBorder.none,
          labelText: widget.hintText,
        ),
      ),
    );
  }
}
