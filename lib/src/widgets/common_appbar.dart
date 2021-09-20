import 'package:flutter/material.dart';
import '/src/navigation/navigation.dart';

import 'ios_arrow._icon.dart';
import 'package:sizer/sizer.dart';

AppBar appbar(BuildContext context, {required String title}) {
  return AppBar(
    leading: IOSarrowIcon(
      onPressed: () => Pop(context),
    ),
    title: FittedBox(
      child: Text(
        title,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        iconSize: 22.sp,
        icon: Icon(Icons.search),
      ),
    ],
  );
}

class CommonAppBar extends StatelessWidget {
  final String title;
  final IconData? actionsIcon;
  final Widget? leading;

  CommonAppBar({
    Key? key,
    required this.title,
    this.actionsIcon = Icons.search,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(10),
      child: AppBar(
        leading: leading == null
            ? null
            : IOSarrowIcon(
                onPressed: () => Pop(context),
              ),
        title: Text(
          title,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(actionsIcon),
          ),
        ],
      ),
    );
  }
}
