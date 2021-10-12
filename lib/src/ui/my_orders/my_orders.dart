import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/models/my_orders_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/ui/my_orders/order_detail.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:sizer/sizer.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, title: 'My Orders'),
      body: _body(),
    );
  }

  _body() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      itemCount: myOrdersDummyList.length,
      itemBuilder: (context, index) {
        var orders = myOrdersDummyList[index];
        return Material(
          child: InkWell(
            onTap: () {
              Push(context, screen: OrderDetail(id: orders.orderId));
            },
            child: Ink(
              child: Column(
                children: [
                  Container(
                    height: 7.h,
                    margin: _margin(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _orderID(orders),
                            _orderDate(orders),
                          ],
                        ),
                        _orderAmount(orders),
                      ],
                    ),
                  ),
                  _divider(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  EdgeInsets _margin() {
    return EdgeInsets.symmetric(
      vertical: 2.h,
      horizontal: 3.w,
    );
  }

  Divider _divider() {
    return Divider(
      color: Black,
      thickness: 0.5,
    );
  }

  Text _orderID(MyOrdersModel orders) {
    return Text(
      "Order ID : ${orders.orderId}",
      style: TextStyle(
        fontSize: 13.sp,
        color: Color(0xff1c1c1c),
      ),
    );
  }

  Text _orderAmount(MyOrdersModel orders) {
    return Text(
      "₹ ${orders.amount}.00",
      style: TextStyle(
        fontSize: 14.sp,
        color: Color(0xff333333),
      ),
    );
  }

  Text _orderDate(MyOrdersModel orders) {
    return Text(
      "Ordered Date : ${orders.orderDate}",
      style: TextStyle(
        fontSize: 9.sp,
        color: Color(0xff4f4f4f),
      ),
    );
  }
}
