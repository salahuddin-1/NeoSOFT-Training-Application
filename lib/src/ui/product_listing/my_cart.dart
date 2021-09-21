import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/blocs/my_cart_quantity_BLOC.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/constants/quantity_list.dart';
import 'package:neosoft_training_application/src/models/my_cart_model.dart';
import 'package:neosoft_training_application/src/resources/my_cart.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:sizer/sizer.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  late MyCartResources _myCartResources;
  late List<MyCartModel> items;

  @override
  void initState() {
    _myCartResources = new MyCartResources();
    items = _myCartResources.items;

    super.initState();
  }

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
        for (int i = 0; i < items.length; i++) _listItem(i),
        _total(),
        _divider(),
        _button(),
      ],
    );
  }

  _listItem(int index) {
    return Dismissible(
      key: ValueKey('$index'),
      direction: DismissDirection.endToStart,
      background: _dissmissibleBackground(),
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

  _total() {
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
            "₹ 180.00",
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

  _button() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Red,
        onPressed: () {},
        child: Center(
          heightFactor: 2.5,
          child: Text(
            'ORDER NOW',
            style: TextStyle(
              fontSize: 14.5.sp,
              color: White,
            ),
          ),
        ),
      ),
    );
  }

  Container _dissmissibleBackground() {
    return Container(
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
              items[index].productImage!,
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
                _QuantityDropDown(
                  quantity: items[index].quantity,
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
      items[index].productName!,
      style: TextStyle(
        color: Grey,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _type(int index) {
    return Text(
      "(${items[index].productType!})",
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 10.sp,
      ),
    );
  }

  Row _price(int index) {
    return Row(
      children: [
        Text(
          "₹" + ' ' + items[index].price! + ".00",
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
      thickness: 1,
    );
  }
}

class _QuantityDropDown extends StatefulWidget {
  final int? quantity;

  const _QuantityDropDown({Key? key, this.quantity}) : super(key: key);
  @override
  _QuantityDropDownState createState() => _QuantityDropDownState();
}

class _QuantityDropDownState extends State<_QuantityDropDown> {
  MyCartQtyBLOC _myCartQtyBLOC = new MyCartQtyBLOC();

  @override
  void dispose() {
    _myCartQtyBLOC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: widget.quantity,
      stream: _myCartQtyBLOC.stream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.all(3),
          alignment: Alignment.center,
          color: Colors.grey[200],
          height: 4.5.h,
          width: 11.w,
          child: DropdownButton<int>(
            onChanged: (val) {
              _myCartQtyBLOC.setValue(val!);
            },
            value: snapshot.data,
            underline: Container(),
            style: TextStyle(
              color: LightGrey,
            ),
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 14.sp,
            ),
            items: quantity
                .map<DropdownMenuItem<int>>(
                  (int value) => DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
