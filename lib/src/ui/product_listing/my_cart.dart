import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/constants/images.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:sizer/sizer.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        title: "My Cart",
      ),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      children: [
        for (int i = 0; i < 3; i++) _listItem(i),
      ],
    );
  }

  _listItem(int index) {
    return Dismissible(
      key: ValueKey('$index'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 5.w),
        child: Container(
          height: 10.w,
          width: 10.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Red,
          ),
          child: Icon(Icons.delete, color: White),
        ),
      ),
      child: Column(
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
      ),
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
              tableImages[index],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _information(int index) {
    return Expanded(
      flex: 5,
      child: Container(
        margin: EdgeInsets.only(right: 2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(index),
                SizedBox(height: 1.h),
                _shopname(index),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _price(index),
                _ratings(index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text _title(int index) {
    return Text(
      'Name',
      style: TextStyle(
        color: Grey,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _shopname(int index) {
    return Text(
      '(Type)',
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 10.sp,
      ),
    );
  }

  var _quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  Widget _price(int index) {
    return Container(
      margin: EdgeInsets.all(3),
      alignment: Alignment.center,
      color: Colors.grey[200],
      height: 4.5.h,
      width: 11.w,
      child: DropdownButton<int>(
        onChanged: (val) {},
        value: 1,
        underline: Container(),
        style: TextStyle(
          color: LightGrey,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_sharp,
          size: 14.sp,
        ),
        items: _quantity
            .map<DropdownMenuItem<int>>(
              (int value) => DropdownMenuItem<int>(
                value: value,
                child: Text('$value'),
              ),
            )
            .toList(),
      ),
    );
  }

  Row _ratings(int index) {
    return Row(
      children: [
        Text(
          "₹ 90.00",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Divider _divider() {
    return Divider(
      height: 0,
      color: Colors.grey,
      thickness: 1.5,
    );
  }
}
