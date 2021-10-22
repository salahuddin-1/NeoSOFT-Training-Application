import 'package:neosoft_training_application/src/blocs/set_ratings_star_BLOC.dart';
import 'package:neosoft_training_application/src/models/product_details_response_model.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../constants/colors.dart';
import '../../blocs_api/set_ratings_BLOC.dart';

class RatingsPopUp {
  late SetRatingBLOC setRatingBLOC;
  late SetRatingsStarBLOC setRatingsStarBLOC;

  String? productId;
  ProductDetailsResponseModel? _productDetailsResponseModel;
  BuildContext? newContext;

  RatingsPopUp({
    required String productId,
    required ProductDetailsResponseModel productDetailsResponseModel,
    required BuildContext context,
  }) {
    this.newContext = context;
    setRatingBLOC = SetRatingBLOC(context);
    setRatingsStarBLOC = SetRatingsStarBLOC();
    this.productId = productId;
    this._productDetailsResponseModel = productDetailsResponseModel;
  }

  int _rating = 5;

  showRatings() {
    return showDialog(
      context: newContext!,
      builder: (context) => Container(
        margin: EdgeInsets.only(
          left: 5.w,
          right: 5.w,
          top: 10.h,
          bottom: 20.h,
        ),
        decoration: BoxDecoration(
          color: White,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 4.h),
                Material(
                  child: Text(
                    _productDetailsResponseModel!.data!.name!,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Black,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                CachedNetworkImage(
                  imageUrl: _productDetailsResponseModel!
                      .data!.productImages![0].image!,
                  height: 25.h,
                ),
                SizedBox(height: 3.h),
                _ratings(),
                _button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _ratings() {
    return StreamBuilder<int>(
        stream: setRatingsStarBLOC.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _rating = snapshot.data!;
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i <= 5; i++)
                Material(
                  child: InkWell(
                    onTap: () {
                      setRatingsStarBLOC.setRatings(i);
                    },
                    child: Icon(
                      Icons.star,
                      color: i <= _rating ? Golden : LightGrey,
                      size: 40.sp,
                    ),
                  ),
                ),
            ],
          );
        });
  }

  _button() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Red,
        onPressed: () {
          _submit();
        },
        child: Center(
          heightFactor: 2.5,
          child: Text(
            'RATE NOW',
            style: TextStyle(
              fontSize: 14.5.sp,
              color: White,
            ),
          ),
        ),
      ),
    );
  }

  _submit() {
    setRatingBLOC.setRatings(
      productId: productId!,
      rating: _rating.toString(),
    );
  }
}
