import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/blocs/slelect_address_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/address_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/order_BLOC.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/models/order_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/ui/homescreen/homescreen.dart';
import 'package:neosoft_training_application/src/ui/product_listing/add_address.dart';
import 'package:neosoft_training_application/src/widgets/circular_progress.dart';
import 'package:neosoft_training_application/src/widgets/error_widget.dart';
import 'package:neosoft_training_application/src/widgets/ios_arrow._icon.dart';
import 'package:neosoft_training_application/src/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class AddressList extends StatefulWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  final _textColor = Color(0xff333333);
  late final AddressBLOC addBLOC;
  SelectAddressBLOC? _selectAddressBLOC;
  int _selectedIndex = 0;
  List<String>? addressList;

  @override
  void didChangeDependencies() {
    addBLOC = BlocProvider.of<AddressBLOC>(context);
    addBLOC.add(Status.LOADING);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _body(),
    );
  }

  _body() {
    return RefreshIndicator(
      color: Red,
      onRefresh: _onRefresh,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: BlocBuilder<AddressBLOC, ApiResponse<List<String>>>(
          builder: (context, state) {
            if (state.status == Status.LOADING) {
              return CircularProgressCustom();
            } else if (state.status == Status.ERROR) {
              return ErrorWidgetCustom(
                message: state.message!,
                onPressed: () {
                  addBLOC.add(Status.LOADING);
                },
              );
            } else if (state.status == Status.COMPLETED) {
              addressList = state.data;

              if (addressList == null || addressList!.isEmpty) {
                return _noAddress();
              }

              return BlocProvider(
                create: (context) => SelectAddressBLOC(),
                child: BlocBuilder<SelectAddressBLOC, Map<int, bool>>(
                  builder: (context, state) {
                    if (_selectAddressBLOC == null) {
                      _selectAddressBLOC =
                          BlocProvider.of<SelectAddressBLOC>(context);
                    }

                    return ListView(
                      children: [
                        Text(
                          'Shipping Address',
                          style: TextStyle(
                            color: _textColor,
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 2.5.h),
                        for (int i = 0; i < addressList!.length; i++)
                          _addressContainer(addressList![i], state[i]!, i),
                        SizedBox(height: 2.5.h),
                        _button(),
                      ],
                    );
                  },
                ),
              );
            }

            return CircularProgressCustom();
          },
        ),
      ),
    );
  }

  Center _noAddress() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Address Added yet",
            style: TextStyle(
              color: Black,
            ),
          ),
          TextButton(
            onPressed: () {
              Push(
                context,
                screen: AddAddress(
                  addBLOC: addBLOC,
                ),
              );
            },
            child: Text(
              "Add Address +",
              style: TextStyle(
                color: Red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh() {
    return Future.delayed(Duration(milliseconds: 100)).then(
      (value) {
        addBLOC.add(Status.LOADING);
      },
    );
  }

  Widget _addressContainer(String text, bool isSelected, int index) {
    return InkWell(
      onTap: () {
        _selectAddressBLOC!.add(index);
        _selectedIndex = index;
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        child: Row(
          children: [
            _radiobutton(isSelected),
            _nameAddress(text),
          ],
        ),
      ),
    );
  }

  Expanded _nameAddress(String text) {
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
                text,
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

  Container _radiobutton(bool isSelected) {
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
          color: isSelected ? Color(0xffbfbfbf) : White,
        ),
      ),
    );
  }

  OrderBLOC? orderBloc;

  Widget _button() {
    return BlocProvider(
      create: (contextt) => OrderBLOC(addressList![_selectedIndex]),
      child: BlocBuilder<OrderBLOC, ApiResponse<OrderResponse>>(
        builder: (blocContext, state) {
          if (orderBloc == null) {
            orderBloc = BlocProvider.of<OrderBLOC>(blocContext);
          }
          return MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: Red,
            onPressed: _order,
            child: Container(
              alignment: Alignment.center,
              height: 7.h,
              child: state.status == Status.LOADING
                  ? CircularProgressCustom(
                      color: White,
                    )
                  : Text(
                      'PLACE ORDER',
                      style: TextStyle(
                        fontSize: 14.5.sp,
                        color: White,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  void _order() {
    orderBloc!.add(Status.LOADING);

    orderBloc!.stream.listen(
      (event) {
        if (event.status == Status.COMPLETED) {
          ShowToast.toast(event.data!.message!, context, 4);
          PushAndRemoveUntil(context, screen: HomeScreen());
        } else if (event.status == Status.ERROR) {
          ShowToast.toast(event.message!, context, 4);
        }
      },
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
              screen: AddAddress(
                addBLOC: addBLOC,
              ),
            );
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
