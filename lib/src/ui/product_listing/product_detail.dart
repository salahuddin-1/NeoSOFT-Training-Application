import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/models/tables_model.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:sizer/sizer.dart';

class ProductDetail extends StatefulWidget {
  final TableModel? tableModel;

  const ProductDetail({
    Key? key,
    required this.tableModel,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isOutOfStock = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        title: widget.tableModel!.tableName,
      ),
      body: _body(),
      bottomSheet: _bottomSheet(),
      backgroundColor: Colors.grey[200],
    );
  }

  Container _bottomSheet() {
    return Container(
      padding: EdgeInsets.all(3.w),
      height: 11.h,
      child: Row(
        children: [
          _button(
            title: 'BUY NOW',
            textColor: White,
            buttonColor: Red,
            onPressed: () {},
          ),
          SizedBox(width: 3.w),
          _button(
            title: 'RATE',
            textColor: Colors.grey[700]!,
            buttonColor: Colors.grey[300]!,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Expanded _button({
    required String title,
    required Color textColor,
    required Color buttonColor,
    required Function onPressed,
  }) {
    return Expanded(
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: buttonColor,
        onPressed: () {
          onPressed();
        },
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.5.sp,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  _body() {
    return ListView(
      children: [
        _header(),
        Container(
          margin: EdgeInsets.all(4.w),
          padding: EdgeInsets.only(left: 3.w, right: 2.w),
          height: 100.h,
          // color: Colors.yellow,
          color: White,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _price(),
                    Row(
                      children: [
                        _isOutOfStock ? _outOfStock() : SizedBox(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            color: LightGrey,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 44.w,
                child: CachedNetworkImage(
                  imageUrl: widget.tableModel!.image,
                  width: 63.w,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1.h),
                height: 19.w,
                // width: 80.w,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Grey,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                              widget.tableModel!.image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: widget.tableModel!.image,
                          fit: BoxFit.cover,
                        ),
                        decoration: BoxDecoration(
                          color: Grey,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Grey,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                              widget.tableModel!.image,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Grey,
                thickness: 0.6,
                height: 10.w,
              ),
              Text(
                "DESCRIPTION",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                ''' 
What is Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has
been the industry's standard dummy text ever since the 1500s when an unknown printer took a 
galley of type and scrambled it to make a type specimen book it has?
''',
                style: TextStyle(
                  color: LightGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Text _outOfStock() {
    return Text(
      "Out of Stock",
      style: TextStyle(
        color: Red,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _price() {
    return Text(
      "Rs. ${widget.tableModel!.price}",
      style: TextStyle(
        color: Red,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Container _header() {
    return Container(
      color: White,
      padding: EdgeInsets.only(left: 4.w, right: 3.w, top: 2.h),
      height: 12.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FittedBox(
            child: Text(
              widget.tableModel!.tableName,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xff262626),
              ),
            ),
          ),
          Text(
            'Category - Tables',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: LightGrey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.tableModel!.shopName,
                style: TextStyle(
                  fontSize: 7.5.sp,
                  fontWeight: FontWeight.w600,
                  color: LightGrey,
                ),
              ),
              _ratings(),
            ],
          ),
        ],
      ),
    );
  }

  Row _ratings() {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Icon(
            Icons.star,
            color: i < widget.tableModel!.ratings ? Golden : LightGrey,
            size: 12.sp,
          ),
      ],
    );
  }
}
