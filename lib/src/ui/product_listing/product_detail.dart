import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/blocs/select_product_detail_image_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api/add_to_cart_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api/get_product_details_BLOC.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/models/add_to_cart_model.dart';
import 'package:neosoft_training_application/src/models/product_details_response_model.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/ui/product_listing/ratings_pop_up.dart';
import 'package:neosoft_training_application/src/widgets/circular_progress.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:neosoft_training_application/src/widgets/error_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

class ProductDetail extends StatefulWidget {
  final String productId;
  final String type;

  const ProductDetail({
    Key? key,
    required this.productId,
    required this.type,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isOutOfStock = false;
  late GetProductDetailsBLOC _getProductDetailsBLOC;
  late AddToCartBLOC _addToCartBLOC;
  late AddtoCartModel addtoCartModel;
  late SelectProductDetailImageBLOC _selectProductDetailImageBLOC;

  ProductDetailsResponseModel? tableModel;
  RatingsPopUp? _ratingsPopUp;

  @override
  void initState() {
    _getProductDetailsBLOC = GetProductDetailsBLOC(
      widget.productId,
    );

    addtoCartModel = AddtoCartModel(
      productId: widget.productId,
      quantity: '1',
    );

    _selectProductDetailImageBLOC = SelectProductDetailImageBLOC();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _addToCartBLOC = AddToCartBLOC(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _getProductDetailsBLOC.dispose();
    _ratingsPopUp!.setRatingBLOC.dispose();
    _ratingsPopUp!.setRatingsStarBLOC.dispose();
    _addToCartBLOC.dispose();
    _selectProductDetailImageBLOC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _getProductDetailsBLOC.getDetails(),
      color: Red,
      child: StreamBuilder<ApiResponse<ProductDetailsResponseModel>>(
        stream: _getProductDetailsBLOC.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                return Container(
                  alignment: Alignment.center,
                  color: White,
                  child: CircularProgressCustom(),
                );

              case Status.ERROR:
                return Scaffold(
                  body: ErrorWidgetCustom(
                    message: snapshot.data!.message!,
                    onPressed: () => _getProductDetailsBLOC.getDetails(),
                  ),
                );

              case Status.COMPLETED:
                tableModel = snapshot.data!.data!;

                String productId =
                    tableModel!.data!.productImages![0].productId!.toString();

                if (_ratingsPopUp == null) {
                  _ratingsPopUp = RatingsPopUp(
                    productId: productId,
                    productDetailsResponseModel: tableModel!,
                    context: context,
                  );
                }

                return Scaffold(
                  appBar: appbar(
                    context,
                    title: tableModel!.data!.name!,
                  ),
                  body: _body(),
                  bottomSheet: _bottomSheet(),
                  backgroundColor: Colors.grey[200],
                );

              default:
            }
          }

          return Container(
            height: 100.h,
            width: 100.w,
            alignment: Alignment.center,
            color: White,
            child: CircularProgressCustom(),
          );
        },
      ),
    );
  }

  Container _bottomSheet() {
    return Container(
      padding: EdgeInsets.all(3.w),
      height: 11.h,
      child: Row(
        children: [
          StreamBuilder<bool>(
            stream: _addToCartBLOC.loadingInstance.stream,
            builder: (context, snapshot) {
              bool isLoading = false;

              if (snapshot.hasData) {
                isLoading = snapshot.data!;
              }

              return _button(
                title: 'BUY NOW',
                textColor: White,
                buttonColor: Red,
                onPressed: () {
                  _addToCartBLOC.addToCart(addtoCartModel);
                },
                isLoading: isLoading,
              );
            },
          ),
          SizedBox(width: 3.w),
          _button(
            title: 'RATE',
            textColor: Colors.grey[700]!,
            buttonColor: Colors.grey[300]!,
            onPressed: _ratingsPopUp!.showRatings,
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
    bool isLoading = false,
  }) {
    return Expanded(
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: buttonColor,
        onPressed: () {
          if (!isLoading) {
            onPressed();
          }
        },
        child: Center(
          child: isLoading
              ? CircularProgressCustom(
                  color: White,
                )
              : Text(
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

// TODO
  Widget _body() {
    return ListView(
      children: [
        _header(),
        StreamBuilder<Map<int, bool>>(
          stream: _selectProductDetailImageBLOC.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final map = snapshot.data;

              return Container(
                margin: EdgeInsets.all(4.w),
                padding: EdgeInsets.only(left: 3.w, right: 2.w),
                height: 100.h,
                color: White,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                      child: map![0]!
                          ? CachedNetworkImage(
                              imageUrl:
                                  tableModel!.data!.productImages![0].image!,
                              width: 63.w,
                              fit: BoxFit.fill,
                            )
                          : ClipRRect(
                              child: Container(
                                width: 63.w,
                                decoration: BoxDecoration(),
                                child: PhotoView(
                                  initialScale: map[1]! ? 0.8 : 1.5,
                                  imageProvider: CachedNetworkImageProvider(
                                    tableModel!.data!.productImages![0].image!,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 1.h),
                      height: 19.w,
                      // width: 80.w,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _selectProductDetailImageBLOC.selectImage(0);
                              },
                              child: Container(
                                child: CachedNetworkImage(
                                  imageUrl: tableModel!
                                      .data!.productImages![0].image!,
                                  fit: BoxFit.cover,
                                ),
                                decoration: BoxDecoration(
                                  color: Grey,
                                  border: Border.all(
                                    width: 1.5,
                                    color: map[0]! ? Red : LightGrey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _selectProductDetailImageBLOC.selectImage(1);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.5,
                                    color: map[1]! ? Red : LightGrey,
                                  ),
                                ),
                                child: ClipRRect(
                                  child: Container(
                                    child: PhotoView(
                                      disableGestures: true,
                                      initialScale: 0.4,
                                      imageProvider: CachedNetworkImageProvider(
                                        tableModel!
                                            .data!.productImages![0].image!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _selectProductDetailImageBLOC.selectImage(2);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.5,
                                    color: map[2]! ? Red : LightGrey,
                                  ),
                                ),
                                child: ClipRRect(
                                  child: Container(
                                    child: PhotoView(
                                      disableGestures: true,
                                      initialScale: 0.7,
                                      basePosition: Alignment.centerRight,
                                      imageProvider: CachedNetworkImageProvider(
                                        tableModel!
                                            .data!.productImages![0].image!,
                                      ),
                                    ),
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
                      tableModel!.data!.description!,
                      style: TextStyle(
                        color: LightGrey,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
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
      "Rs. ${tableModel!.data!.cost}",
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
              tableModel!.data!.name!,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xff262626),
              ),
            ),
          ),
          Text(
            'Category - ${widget.type}',
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
                tableModel!.data!.producer!,
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

  Widget _ratings() {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            for (int i = 1; i <= 5; i++)
              Icon(
                Icons.star,
                color: i <= tableModel!.data!.rating! ? Golden : LightGrey,
                size: 12.sp,
              ),
          ],
        ),
      ),
    );
  }
}
