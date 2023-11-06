import 'package:flutter/material.dart';

class ButtonFragment extends StatelessWidget {
  const ButtonFragment(
      {super.key,
      required this.onClick,
      required this.child,
      this.isDisabled = false});

  final Widget child;
  final bool isDisabled;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: isDisabled ? null : onClick, child: child);
  }
}
