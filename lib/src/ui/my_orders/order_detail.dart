import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/order_BLOC.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/models/order_model.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/widgets/circular_progress.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:neosoft_training_application/src/widgets/error_widget.dart';
import 'package:sizer/sizer.dart';

class OrderDetail extends StatefulWidget {
  final String id;

  const OrderDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late OrderDetailBLOC _orderDetailBLOC;
  OrderDetailResponse? _orderDetailResponse;
  @override
  void didChangeDependencies() {
    _orderDetailBLOC = BlocProvider.of<OrderDetailBLOC>(context);
    _orderDetailBLOC.add(Status.LOADING);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        title: 'Order ID : ${widget.id}',
      ),
      body: RefreshIndicator(
        color: Red,
        onRefresh: () => _onRefresh(),
        child: BlocBuilder<OrderDetailBLOC, ApiResponse<OrderDetailResponse>>(
          builder: (context, state) {
            if (state.status == Status.LOADING) {
              return Center(
                child: CircularProgressCustom(),
              );
            } else if (state.status == Status.ERROR) {
              return ErrorWidgetCustom(
                message: state.message!,
                onPressed: () {
                  _orderDetailBLOC.add(Status.LOADING);
                },
              );
            } else if (state.status == Status.COMPLETED) {
              if (_orderDetailResponse == null) {
                _orderDetailResponse = state.data!;
              }

              int length = _orderDetailResponse!.data!.orderDetails!.length;

              return ListView(
                children: [
                  for (int i = 0; i < length; i++) _listItem(i),
                  _total(),
                  _divider(),
                  SizedBox(height: 5.h),
                ],
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Future _onRefresh() {
    return Future.delayed(Duration(milliseconds: 100)).then(
      (value) {
        _orderDetailBLOC.add(Status.LOADING);
      },
    );
  }

  _listItem(int index) {
    return Column(
      children: [
        Container(
          height: 16.h,
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 2.1.h,
              horizontal: 1.3.w,
            ),
            child: Row(
              children: [
                _image(index),
                _information(index),
              ],
            ),
          ),
        ),
        _divider(),
      ],
    );
  }

  Expanded _image(int index) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: BoxDecoration(
          color: Grey,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              _orderDetailResponse!.data!.orderDetails![index].prodImage!,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _information(int index) {
    String quantity =
        _orderDetailResponse!.data!.orderDetails![index].quantity.toString();

    return Expanded(
      flex: 5,
      child: Container(
        margin: EdgeInsets.only(right: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(index),
                SizedBox(height: 1.h),
                _type(index),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'QTY : $quantity',
                  style: TextStyle(
                    color: Color(0xff333333),
                  ),
                ),
                _price(index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text _title(int index) {
    return Text(
      _orderDetailResponse!.data!.orderDetails![index].prodName!,
      style: TextStyle(
        color: Grey,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _type(int index) {
    return Text(
      "(${_orderDetailResponse!.data!.orderDetails![index].prodCatName!})",
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 10.sp,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Row _price(int index) {
    String price =
        _orderDetailResponse!.data!.orderDetails![index].total.toString();
    return Row(
      children: [
        Text(
          "₹" + ' ' + price + ".00",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  _total() {
    String total = _orderDetailResponse!.data!.cost.toString();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.3.w),
      height: 10.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "TOTAL",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
          Text(
            "₹ " + total,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Divider _divider() {
    return Divider(
      height: 0,
      color: Colors.grey,
      thickness: 1,
    );
  }
}
