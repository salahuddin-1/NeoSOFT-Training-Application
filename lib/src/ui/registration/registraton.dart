import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/blocs/radio_buttons_bloc.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/ui/homescreen/homescreen.dart';
import 'package:neosoft_training_application/src/widgets/background_gradient.dart';
import 'package:neosoft_training_application/src/widgets/login_register_button.dart';
import 'package:neosoft_training_application/src/widgets/textfield_border_decoration.dart';
import 'package:sizer/sizer.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late final RadioButtonsBloc _radioBloc;

  @override
  void initState() {
    _radioBloc = new RadioButtonsBloc();

    super.initState();
  }

  @override
  void dispose() {
    _radioBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Container(
        decoration: _boxDecoration(),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
          children: [
            Column(
              children: [
                SizedBox(height: 5.h),
                _title(),
                SizedBox(height: 3.h),
                _firstNameTextField(),
                SizedBox(height: 2.h),
                _lastNameTextField(),
                SizedBox(height: 2.h),
                _emailTextField(),
                SizedBox(height: 2.h),
                _passwordTextField(),
                SizedBox(height: 2.h),
                _confirmPasswordTextField(),
                _gender(),
                _phoneNumberTextField(),
                _termsAndConditions(),
                LoginRegisterButton(
                  title: 'REGISTER',
                  onPressed: () {
                    Push(context, screen: HomeScreen());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _termsAndConditions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<bool>(
          initialData: false,
          stream: _radioBloc.termsAndConditionsStream,
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {
                _radioBloc.selectTermsAndConditions();
              },
              child: Container(
                height: 3.5.w,
                width: 3.5.w,
                color: Colors.white,
                margin: EdgeInsets.only(right: 10),
                child: Container(
                  color: Colors.red,
                  margin: EdgeInsets.all(1),
                  child: snapshot.data!
                      ? Container(
                          color: Colors.white,
                          margin: EdgeInsets.all(2.5),
                        )
                      : Container(),
                ),
              ),
            );
          },
        ),
        Text(
          "I agree the",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Terms and conditions",
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Padding _gender() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: StreamBuilder<Map<String, bool>>(
        stream: _radioBloc.genderStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Gender',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _radioBloc.selectGender('male');
                  },
                  child: _maleButton(
                    'Male',
                    isSelected: snapshot.data!['male']!,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _radioBloc.selectGender('female');
                  },
                  child: _maleButton(
                    'Female',
                    isSelected: snapshot.data!['female']!,
                  ),
                ),
              ],
            );
          }
          return Text('');
        },
      ),
    );
  }

  _maleButton(String gender, {required bool isSelected}) {
    return Container(
      height: 3.h,
      child: Row(
        children: [
          Container(
            height: 4.w,
            width: 4.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: isSelected
                ? Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  )
                : Container(),
          ),
          SizedBox(width: 2.w),
          Text(
            gender,
            textScaleFactor: 1.1,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  TextFormField _firstNameTextField() {
    return TextFormField(
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.person,
        labelText: 'First Name',
      ),
    );
  }

  TextFormField _lastNameTextField() {
    return TextFormField(
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.person,
        labelText: 'Last Name',
      ),
    );
  }

  TextFormField _emailTextField() {
    return TextFormField(
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.email,
        labelText: 'Email',
      ),
    );
  }

  TextFormField _passwordTextField() {
    return TextFormField(
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.lock,
        labelText: 'Password',
      ),
    );
  }

  TextFormField _confirmPasswordTextField() {
    return TextFormField(
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.lock,
        labelText: 'Confirm Password',
      ),
    );
  }

  TextFormField _phoneNumberTextField() {
    return TextFormField(
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.phone_android,
        labelText: 'Phone Number',
      ),
    );
  }

  TextStyle _inputColor() => TextStyle(color: White);

  Container _title() {
    return Container(
      child: Text(
        'NeoSTORE',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 31.sp,
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(gradient: gradient());
  }

  AppBar _appbar() {
    return AppBar(
      title: Text("Register"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Pop(context),
      ),
    );
  }
}
