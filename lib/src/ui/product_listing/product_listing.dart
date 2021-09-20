import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/constants/images.dart';
import 'package:neosoft_training_application/src/models/tables_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:sizer/sizer.dart';

import 'product_detail.dart';

class ProductListing extends StatefulWidget {
  final String title;

  ProductListing({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _ProductListingState createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, title: 'Tables'),
      body: ListView.builder(
        itemCount: tableModel.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Push(
                context,
                screen: ProductDetail(
                  tableModel: tableModel[index],
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0.7.h),
                  height: 18.h,
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
        },
      ),
    );
  }

  Expanded _information(int index) {
    return Expanded(
      flex: 2,
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

  Divider _divider() {
    return Divider(
      height: 0,
      color: Colors.grey,
      thickness: 1.5,
    );
  }

  Row _ratings(int index) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Icon(
            Icons.star,
            color: i < tableModel[index].ratings ? Golden : LightGrey,
            size: 12.sp,
          ),
      ],
    );
  }

  Text _price(int index) {
    return Text(
      "Rs. ${tableModel[index].price}",
      style: TextStyle(
        color: Red,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _shopname(int index) {
    return Text(
      tableModel[index].shopName,
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 8.sp,
      ),
    );
  }

  Text _title(int index) {
    return Text(
      tableModel[index].tableName,
      style: TextStyle(
        color: Grey,
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Expanded _image(int index) {
    return Expanded(
      flex: 1,
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
}
