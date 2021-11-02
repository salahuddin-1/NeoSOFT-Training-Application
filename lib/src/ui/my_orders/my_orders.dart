import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/order_BLOC.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/models/order_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/ui/my_orders/order_detail.dart';
import 'package:neosoft_training_application/src/widgets/circular_progress.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:neosoft_training_application/src/widgets/error_widget.dart';
import 'package:sizer/sizer.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  late OrdersListBLOC _ordersListBLOC;
  OrdersListResponse? _ordersListResponse;

  @override
  void didChangeDependencies() {
    _ordersListBLOC = BlocProvider.of<OrdersListBLOC>(context);
    _ordersListBLOC.add(Status.LOADING);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, title: 'My Orders'),
      body: _body(),
    );
  }

  _body() {
    return RefreshIndicator(
      color: Red,
      onRefresh: () => _onRefresh(),
      child: BlocBuilder<OrdersListBLOC, ApiResponse<OrdersListResponse>>(
        builder: (context, state) {
          if (state.status == Status.LOADING) {
            return Center(
              child: CircularProgressCustom(),
            );
          } else if (state.status == Status.COMPLETED) {
            if (_ordersListResponse == null) {
              _ordersListResponse = state.data;
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              itemCount: _ordersListResponse!.data!.length,
              itemBuilder: (context, index) {
                var orders =
                    _ordersListResponse!.data!.reversed.toList()[index];

                return Material(
                  child: InkWell(
                    onTap: () {
                      Push(
                        context,
                        screen: BlocProvider(
                          create: (context) => OrderDetailBLOC(
                            orders.id.toString(),
                          ),
                          child: OrderDetail(
                            id: orders.id.toString(),
                          ),
                        ),
                      );
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _orderID(
                                      orders.id.toString(),
                                    ),
                                    _orderDate(orders.created!),
                                  ],
                                ),
                                _orderAmount(
                                  orders.cost.toString(),
                                ),
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
          } else if (state.status == Status.ERROR) {
            return ErrorWidgetCustom(
              message: state.message!,
              onPressed: () => _ordersListBLOC.add(Status.LOADING),
            );
          }

          return Center(
            child: CircularProgressCustom(),
          );
        },
      ),
    );
  }

  Future _onRefresh() {
    return Future.delayed(Duration(milliseconds: 100)).then(
      (value) {
        _ordersListBLOC.add(Status.LOADING);
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

  Text _orderID(String id) {
    return Text(
      "Order ID : $id",
      style: TextStyle(
        fontSize: 13.sp,
        color: Color(0xff1c1c1c),
      ),
    );
  }

  Text _orderAmount(String amount) {
    return Text(
      "₹ $amount.00",
      style: TextStyle(
        fontSize: 14.sp,
        color: Color(0xff333333),
      ),
    );
  }

  Text _orderDate(String date) {
    return Text(
      "Ordered Date : $date",
      style: TextStyle(
        fontSize: 9.sp,
        color: Color(0xff4f4f4f),
      ),
    );
  }
}
