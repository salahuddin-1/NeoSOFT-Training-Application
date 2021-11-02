import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/blocs/my_cart_quantity_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api/edit_cart_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/address_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/delete_item_from_cart_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/get_list_cart_items_BLOC.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/models/edit_cart_model.dart';
import 'package:neosoft_training_application/src/models/get_list_cart_items_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/get_list_cart_items_repo.dart';
import 'package:neosoft_training_application/src/ui/product_listing/address_list.dart';
import 'package:neosoft_training_application/src/validation/quantity_validation.dart';
import 'package:neosoft_training_application/src/widgets/circular_progress.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:neosoft_training_application/src/widgets/error_widget.dart';
import 'package:neosoft_training_application/src/widgets/toast.dart';
import 'package:sizer/sizer.dart';

GetListCartItemsResponse? _getListCartItemsResponse;

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  late GetListCartItemsBLOC _getListCartItemsBLOC;

  @override
  void didChangeDependencies() {
    _getListCartItemsBLOC = BlocProvider.of<GetListCartItemsBLOC>(context);
    _getListCartItemsBLOC.add(Status.LOADING);

    super.didChangeDependencies();
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
    return RefreshIndicator(
      color: Red,
      onRefresh: _onRefresh,
      child: BlocBuilder<GetListCartItemsBLOC,
          ApiResponse<GetListCartItemsResponse>>(
        builder: (context, response) {
          if (response.status == Status.ERROR) {
            return ErrorWidgetCustom(
              message: response.message!,
              onPressed: _onRefresh,
            );
          } else if (response.status == Status.COMPLETED) {
            _getListCartItemsResponse = response.data;

            if (_getListCartItemsResponse!.data == null)
              return const _EmptyText();

            int length = _getListCartItemsResponse!.data!.length;

            return ListView(
              children: [
                for (int i = 0; i < length; i++) _listItem(i),
                _total(),
                _divider(),
                _button(),
              ],
            );
          }
          return Center(
            child: CircularProgressCustom(
              color: Red,
            ),
          );
        },
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

  _listItem(int index) {
    final productId =
        _getListCartItemsResponse!.data![index].productId.toString();

    return BlocProvider(
      create: (context) => DeleteItemFromCartBLOC(productId),
      child: _ListItemDismissible(
        index: index,
        getListCartItemsResponse: _getListCartItemsResponse,
        getListCartItemsBLOC: _getListCartItemsBLOC,
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
            "₹ " + _getListCartItemsResponse!.total!.toString(),
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
        onPressed: () {
          Push(
            context,
            screen: BlocProvider(
              create: (context) => AddressBLOC(),
              child: AddressList(),
            ),
          );
        },
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

  Future _onRefresh() {
    return Future.delayed(Duration(milliseconds: 100)).then(
      (value) {
        GetListCartItemsRepo().getListCartItems();
        _getListCartItemsBLOC.add(Status.LOADING);
      },
    );
  }
}

class _EmptyText extends StatelessWidget {
  const _EmptyText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Cart is Empty",
        style: TextStyle(color: Black),
      ),
    );
  }
}

class _Quantity extends StatefulWidget {
  _Quantity({
    Key? key,
    required this.index,
    this.quantity,
    required this.getListCartItemsBLOC,
  }) : super(key: key);

  final int index;
  final int? quantity;
  final GetListCartItemsBLOC getListCartItemsBLOC;

  @override
  __QuantityState createState() => __QuantityState();
}

class __QuantityState extends State<_Quantity> {
  late MyCartQtyBLOC _myCartQtyBLOC;

  @override
  void initState() {
    _myCartQtyBLOC = new MyCartQtyBLOC();
    _myCartQtyBLOC.setValue(widget.quantity!);
    super.initState();
  }

  @override
  void dispose() {
    _myCartQtyBLOC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showQuantityDialog(widget.index);
      },
      child: Container(
        margin: EdgeInsets.all(3),
        alignment: Alignment.center,
        color: Colors.grey[200],
        height: 4.5.h,
        width: 11.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              initialData: 1,
              stream: _myCartQtyBLOC.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data}',
                    style: TextStyle(
                      color: LightGrey,
                    ),
                  );
                }
                return SizedBox();
              },
            ),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 14.sp,
              color: Grey,
            ),
          ],
        ),
      ),
    );
  }

  _showQuantityDialog(int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return _QuantityDialogUI(
          index: index,
          myCartQtyBLOC: _myCartQtyBLOC,
          getListCartItemsBLOC: widget.getListCartItemsBLOC,
        );
      },
    );
  }
}

class _QuantityDialogUI extends StatefulWidget {
  _QuantityDialogUI({
    Key? key,
    required this.index,
    required this.myCartQtyBLOC,
    required this.getListCartItemsBLOC,
  }) : super(key: key);

  final int index;
  final MyCartQtyBLOC myCartQtyBLOC;
  final GetListCartItemsBLOC getListCartItemsBLOC;

  @override
  __QuantityDialogUIState createState() => __QuantityDialogUIState();
}

class __QuantityDialogUIState extends State<_QuantityDialogUI> {
  final double height = 2;

  late final TextEditingController _editingController;
  late EditCartBLOC _editCartBLOC;

  @override
  void initState() {
    _editingController = TextEditingController(
      text: widget.myCartQtyBLOC.value.toString(),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _editCartBLOC = EditCartBLOC(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _editingController.dispose();
    _editCartBLOC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 11.h, horizontal: 20),
      color: Colors.green,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _title(),
                SizedBox(height: height.h),
                _image(),
                SizedBox(height: height.h),
                _subtitle(),
                SizedBox(height: height.h),
                _quantityTextField(),
                SizedBox(height: height.h),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _submitButton() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20.w,
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Red,
        onPressed: _submitQuantity,
        child: Container(
          alignment: Alignment.center,
          height: 7.h,
          child: StreamBuilder<bool>(
            stream: _editCartBLOC.loadingInstance.stream,
            builder: (context, snapshot) {
              bool isLoading = false;

              if (snapshot.hasData) {
                isLoading = snapshot.data!;
              }

              return isLoading
                  ? CircularProgressCustom(
                      color: White,
                    )
                  : Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontSize: 14.5.sp,
                        color: White,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Container _quantityTextField() {
    return Container(
      width: 25.w,
      child: TextFormField(
        controller: _editingController,
        cursorColor: Black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(),
            borderSide: BorderSide(
              color: Colors.green,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: White,
          isDense: true,
          focusColor: Colors.green,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(),
            borderSide: BorderSide(
              color: Colors.green,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(fontSize: 9.sp),
        onChanged: (val) {
          if (val.isNotEmpty) {
            int value = int.tryParse(val)!;
            widget.myCartQtyBLOC.setValue(value);
          }
        },
      ),
    );
  }

  Text _subtitle() {
    return Text(
      'Enter Qty',
      style: TextStyle(
        color: Black,
        fontSize: 13.sp,
      ),
    );
  }

  Text _title() {
    return Text(
      "${_getListCartItemsResponse!.data![widget.index].product!.name!}",
      style: TextStyle(
        color: Black,
        fontSize: 18.sp,
      ),
    );
  }

  Container _image() {
    return Container(
      height: 35.h,
      width: 80.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            "${_getListCartItemsResponse!.data![widget.index].product!.productImages!}",
          ),
        ),
      ),
    );
  }

  void _submitQuantity() {
    final _quantity = _editingController.text.trim();

    if (!QuantityValidation.isQuantityValidate(
      _quantity,
    )) {
      ShowToast.errorToast(
        'Quantity should be in between 1 - 8',
        context,
        4,
      );
      return;
    }
    final productId =
        _getListCartItemsResponse!.data![widget.index].productId.toString();

    final editCartModel = EditCartModel(
      productId: productId,
      quantity: _quantity,
    );

    _editCartBLOC.editCart(editCartModel);

    widget.getListCartItemsBLOC.add(Status.LOADING);
  }
}

class _ListItemDismissible extends StatefulWidget {
  final int index;
  final GetListCartItemsResponse? getListCartItemsResponse;
  final GetListCartItemsBLOC getListCartItemsBLOC;

  _ListItemDismissible({
    required this.index,
    required this.getListCartItemsResponse,
    required this.getListCartItemsBLOC,
  });

  @override
  __ListItemDismissibleState createState() => __ListItemDismissibleState();
}

class __ListItemDismissibleState extends State<_ListItemDismissible> {
  late int index = widget.index;
  late GetListCartItemsResponse _getListCartItemsResponse =
      widget.getListCartItemsResponse!;
  late final DeleteItemFromCartBLOC _deleteItemProvider;

  @override
  void didChangeDependencies() {
    _deleteItemProvider = BlocProvider.of<DeleteItemFromCartBLOC>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (val) async => await _delete(),
      onDismissed: (val) {
        widget.getListCartItemsBLOC.add(Status.LOADING);
      },
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

  Future<bool> _delete() async {
    _deleteItemProvider.add(Status.LOADING);

    bool dis = false;

    _deleteItemProvider.stream.listen(
      (state) {
        if (state.status == Status.COMPLETED) {
          dis = true;

          ShowToast.toast(state.data!.userMsg!, context, 3);
        } else if (state.status == Status.ERROR) {
          dis = false;
          ShowToast.toast(state.data!.userMsg!, context, 3);
        }
      },
    );
    await Future.delayed(Duration(seconds: 1));

    return dis;
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
              _getListCartItemsResponse.data![index].product!.productImages!,
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
                _Quantity(
                  index: index,
                  quantity: _getListCartItemsResponse.data![index].quantity,
                  getListCartItemsBLOC: widget.getListCartItemsBLOC,
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
      _getListCartItemsResponse.data![index].product!.name!,
      style: TextStyle(
        color: Grey,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _type(int index) {
    return Text(
      "(${_getListCartItemsResponse.data![index].product!.productCategory})",
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 10.sp,
      ),
    );
  }

  Row _price(int index) {
    String price =
        _getListCartItemsResponse.data![index].product!.cost!.toString();
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

  Divider _divider() {
    return Divider(
      height: 0,
      color: Colors.grey,
      thickness: 1,
    );
  }
}
