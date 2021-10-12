import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/ui/product_listing/add_address.dart';
import 'package:neosoft_training_application/src/widgets/ios_arrow._icon.dart';
import 'package:sizer/sizer.dart';

class AddressList extends StatefulWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  final _textColor = Color(0xff333333);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: ListView(
        children: [
          Text(
            'Shipping Address',
            style: TextStyle(
              color: _textColor,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 2.5.h),
          _addressContainer(),
          _addressContainer(),
          _addressContainer(),
          SizedBox(height: 2.5.h),
          _button(),
        ],
      ),
    );
  }

  Container _addressContainer() {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          _radiobutton(),
          _nameAddress(),
        ],
      ),
    );
  }

  Expanded _nameAddress() {
    return Expanded(
      child: Container(
        color: Colors.grey[300],
        margin: EdgeInsets.only(left: 3.w),
        child: Container(
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
          color: White,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Glen Dmello',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: _textColor,
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.grey[300],
                    size: 12.sp,
                  ),
                ],
              ),
              SizedBox(height: 1.5.h),
              Text(
                "Plot no 1, Mandli Talav, Opp Atlake Hotel, Near rachna apt, Mandli Talav Bhayander West, Thane 401101",
                style: TextStyle(
                  color: _textColor,
                  letterSpacing: 0.3,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _radiobutton() {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff8e8e8e),
      ),
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffbfbfbf), // White,
        ),
      ),
    );
  }

  MaterialButton _button() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: Red,
      onPressed: () {},
      child: Center(
        heightFactor: 2.5,
        child: Text(
          'PLACE ORDER',
          style: TextStyle(
            fontSize: 14.5.sp,
            color: White,
          ),
        ),
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      title: Text("Address List"),
      leading: IOSarrowIcon(
        onPressed: () => Pop(context),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Push(
              context,
              screen: AddAddress(),
            );
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
