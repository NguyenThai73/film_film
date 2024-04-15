import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogBottomSheetTemp extends StatelessWidget {
  final Widget child;

  const DialogBottomSheetTemp({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
               context.pop();
            },
            child: child,
          ),
        ),
      ),
    );
  }
}
