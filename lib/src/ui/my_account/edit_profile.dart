import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/constants/images.dart';
import 'package:neosoft_training_application/src/widgets/background_gradient.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:neosoft_training_application/src/widgets/textfield_border_decoration.dart';
import 'package:sizer/sizer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, title: "Edit Profile"),
      body: _body(),
      resizeToAvoidBottomInset: false,
    );
  }

  _body() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
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
      ),
    );
  }

  MaterialButton _submit() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {},
      height: 7.h,
      minWidth: double.infinity,
      color: White,
      child: Text(
        'SUBMIT',
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
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.cake_sharp,
        labelText: 'DOB',
      ),
    );
  }

  TextStyle _inputColor() => TextStyle(color: White);

  SizedBox get _sizeBox => SizedBox(height: 2.h);
}
