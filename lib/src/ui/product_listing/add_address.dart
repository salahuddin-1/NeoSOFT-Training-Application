import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:sizer/sizer.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, title: 'Add Address'),
      body: _body(),
    );
  }

  _body() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: ListView(
        padding: EdgeInsets.only(bottom: 5.h),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _address(),
              SizedBox(height: 4.h),
              _landmark(),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _smallTextField("CITY"),
                  SizedBox(width: 4.w),
                  _smallTextField("STATE"),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _smallTextField('ZIP CODE'),
                  SizedBox(width: 4.w),
                  _smallTextField("COUNTRY"),
                ],
              ),
              SizedBox(height: 4.h),
              _button()
            ],
          ),
        ],
      ),
    );
  }

  Text _title(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Black,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Column _address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('ADDRESS'),
        SizedBox(height: 2.h),
        TextFormField(
          maxLines: 4,
          cursorColor: Black,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: White,
          ),
        ),
      ],
    );
  }

  Column _landmark() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('LANDMARK'),
        SizedBox(height: 2.h),
        TextFormField(
          cursorColor: Black,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: White,
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(11),
          ),
          style: TextStyle(fontSize: 9.sp),
        ),
      ],
    );
  }

  Expanded _smallTextField(String title) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(title),
          SizedBox(height: 2.h),
          TextFormField(
            cursorColor: Black,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: White,
              isDense: true,
              contentPadding: EdgeInsets.all(11),
            ),
            style: TextStyle(fontSize: 9.sp),
          ),
        ],
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
          'SAVE ADDRESS',
          style: TextStyle(
            fontSize: 14.5.sp,
            color: White,
          ),
        ),
      ),
    );
  }
}
