import 'package:flutter/material.dart';

class Push {
  Push(BuildContext context, {required Widget screen}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}

class Pop {
  Pop(BuildContext context) {
    Navigator.pop(context);
  }
}

class PushAndRemoveUntil {
  PushAndRemoveUntil(BuildContext context, {required Widget screen}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false,
    );
  }
}
