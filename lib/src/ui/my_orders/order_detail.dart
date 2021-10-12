import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';

class OrderDetail extends StatelessWidget {
  final String id;

  const OrderDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, title: 'Order ID $id'),
    );
  }
}
