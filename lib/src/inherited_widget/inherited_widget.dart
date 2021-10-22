import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/blocs_api/get_account_details_BLOC.dart';

class GetAccountDetailsBLOCProvider extends InheritedWidget {
  final GetAccountDetailsBLOC bloc;
  final Widget child;

  GetAccountDetailsBLOCProvider({
    required this.child,
    required this.bloc,
  }) : super(child: child);

  @override
  bool updateShouldNotify(GetAccountDetailsBLOCProvider oldWidget) {
    return bloc != oldWidget.bloc;
  }

  static GetAccountDetailsBLOCProvider of(BuildContext context) {
    return (context
        .dependOnInheritedWidgetOfExactType<GetAccountDetailsBLOCProvider>()!);
  }
}
