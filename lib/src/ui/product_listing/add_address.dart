import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/address_BLOC.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/save_address_to_local_storage.dart';
import 'package:neosoft_training_application/src/validation/address_validation.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:sizer/sizer.dart';

class AddAddress extends StatefulWidget {
  final AddressBLOC addBLOC;

  AddAddress({
    required this.addBLOC,
  });
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  late final SaveAddressToLocalStorage _saveAddressToLocalStorage;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _addressCntrl;
  late TextEditingController _landMarkCntrl;
  late TextEditingController _cityCntrl;
  late TextEditingController _stateCntrl;
  late TextEditingController _zipcodeCntrl;
  late TextEditingController _countryCntrl;

  @override
  void initState() {
    _saveAddressToLocalStorage = SaveAddressToLocalStorage();

    _addressCntrl = TextEditingController();
    _landMarkCntrl = TextEditingController();
    _cityCntrl = TextEditingController();
    _stateCntrl = TextEditingController();
    _zipcodeCntrl = TextEditingController();
    _countryCntrl = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _addressCntrl.dispose();
    _landMarkCntrl.dispose();
    _cityCntrl.dispose();
    _stateCntrl.dispose();
    _zipcodeCntrl.dispose();
    _countryCntrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, title: 'Add Address'),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
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
                    _smallTextField(
                      "CITY",
                      controller: _cityCntrl,
                      validator: (val) {
                        return AddressValidation.city(val);
                      },
                    ),
                    SizedBox(width: 4.w),
                    _smallTextField(
                      "STATE",
                      controller: _stateCntrl,
                      validator: (val) {
                        return AddressValidation.state(val);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _smallTextField(
                      'ZIP CODE',
                      controller: _zipcodeCntrl,
                      validator: (val) {
                        return AddressValidation.zipcode(val);
                      },
                    ),
                    SizedBox(width: 4.w),
                    _smallTextField(
                      "COUNTRY",
                      controller: _countryCntrl,
                      validator: (val) {
                        return AddressValidation.country(val);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                _button()
              ],
            ),
          ],
        ),
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
          controller: _addressCntrl,
          validator: (val) => AddressValidation.address(val!),
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
          controller: _landMarkCntrl,
          validator: (val) => AddressValidation.landmark(val!),
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

  Expanded _smallTextField(
    String title, {
    required TextEditingController controller,
    required Function(String) validator,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(title),
          SizedBox(height: 2.h),
          TextFormField(
            controller: controller,
            cursorColor: Black,
            validator: (val) {
              return validator(val!);
            },
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

  String get _combineAddress {
    final String address = _addressCntrl.text +
        " " +
        _landMarkCntrl.text +
        " " +
        _cityCntrl.text +
        " " +
        _stateCntrl.text +
        " " +
        _zipcodeCntrl.text +
        " " +
        _countryCntrl.text;

    return address;
  }

  MaterialButton _button() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: Red,
      onPressed: _addAddress,
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

  void _addAddress() {
    if (_formKey.currentState!.validate()) {
      widget.addBLOC.add(Status.LOADING);
      _saveAddressToLocalStorage.saveAddress(_combineAddress);
      Pop(context);
    }
  }
}
