import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/constants/images.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/ui/login/reset_password.dart';
import 'package:neosoft_training_application/src/widgets/background_gradient.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:neosoft_training_application/src/widgets/textfield_border_decoration.dart';
import 'package:sizer/sizer.dart';

import 'edit_profile.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late final TextEditingController _firstNameCntrl;
  late final TextEditingController _lasttNameCntrl;
  late final TextEditingController _emailCntrl;
  late final TextEditingController _phoneCntrlCntrl;
  late final TextEditingController _dobCntrl;

  @override
  void initState() {
    _firstNameCntrl = new TextEditingController();
    _lasttNameCntrl = new TextEditingController();
    _emailCntrl = new TextEditingController();
    _phoneCntrlCntrl = new TextEditingController();
    _dobCntrl = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, title: "My Account"),
      body: _body(),
      resizeToAvoidBottomInset: false,
      bottomSheet: const _ResetPassword(),
    );
  }

  _body() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: FutureBuilder<Object>(
          future: null,
          builder: (context, snapshot) {
            _firstNameCntrl.text = 'Salahuddin';
            _lasttNameCntrl.text = 'Shaikh';
            _emailCntrl.text = 'salahuddinshaikh16@gmail.com';
            _phoneCntrlCntrl.text = '8898911744';
            _dobCntrl.text = '01-01-1999';

            return Container(
              decoration: _boxDecoration(),
              child: ListView(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 20.w),
                children: [
                  _profilePic(),
                  _firstNameTextField(),
                  _sizeBox,
                  _lastNameTextField(),
                  _sizeBox,
                  _emailTextField(),
                  _sizeBox,
                  _phoneTextField(),
                  _sizeBox,
                  _dobTextField(),
                  SizedBox(height: 2.5.h),
                  _submit(),
                ],
              ),
            );
          }),
    );
  }

  MaterialButton _submit() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {
        Push(context, screen: EditProfile());
      },
      height: 7.h,
      minWidth: double.infinity,
      color: White,
      child: Text(
        'EDIT PROFILE',
        style: TextStyle(
          color: Red,
          fontWeight: FontWeight.w700,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Center _profilePic() {
    return Center(
      heightFactor: 1.3,
      child: Container(
        height: 33.w,
        width: 33.w,
        decoration: BoxDecoration(
          color: White,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              images[0],
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(gradient: gradient());

  TextFormField _firstNameTextField() {
    return TextFormField(
      readOnly: true,
      controller: _firstNameCntrl,
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.person,
        labelText: 'First name',
      ),
    );
  }

  TextFormField _lastNameTextField() {
    return TextFormField(
      readOnly: true,
      controller: _lasttNameCntrl,
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.person,
        labelText: 'Last name',
      ),
    );
  }

  TextFormField _emailTextField() {
    return TextFormField(
      readOnly: true,
      controller: _emailCntrl,
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.mail,
        labelText: 'Email',
      ),
    );
  }

  TextFormField _phoneTextField() {
    return TextFormField(
      readOnly: true,
      controller: _phoneCntrlCntrl,
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.phone_android,
        labelText: 'Phone number',
      ),
    );
  }

  TextFormField _dobTextField() {
    return TextFormField(
      readOnly: true,
      controller: _dobCntrl,
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.cake_sharp,
        labelText: 'Date of birth',
      ),
    );
  }

  TextStyle _inputColor() => TextStyle(color: White);

  SizedBox get _sizeBox => SizedBox(height: 2.h);
}

class _ResetPassword extends StatelessWidget {
  const _ResetPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Push(context, screen: ResetPassword());
      },
      color: Colors.white,
      height: 7.h,
      minWidth: double.infinity,
      child: Text(
        "RESET PASSWORD",
        style: TextStyle(
          color: Color(0xff333333),
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
