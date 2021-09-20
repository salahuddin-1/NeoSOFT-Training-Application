import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/ui/login/forgot_pasword.dart';
import 'package:neosoft_training_application/src/ui/registration/registraton.dart';
import 'package:neosoft_training_application/src/widgets/background_gradient.dart';
import 'package:neosoft_training_application/src/widgets/login_register_button.dart';
import 'package:neosoft_training_application/src/widgets/textfield_border_decoration.dart';
import '/src/constants/colors.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _dontHaveAnAccount(),
      body: Container(
        decoration: _boxDecoration(),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _title(),
                  SizedBox(height: 7.5.h),
                  _usernameTextField(),
                  SizedBox(height: 3.h),
                  _passwordTextField(),
                  SizedBox(height: 6.h),
                  LoginRegisterButton(
                    title: 'LOGIN',
                    onPressed: () {},
                  ),
                  SizedBox(height: 1.5.h),
                  _forgotPasswordButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(gradient: gradient());
  }

  Container _title() {
    return Container(
      child: Text(
        'NeoSTORE',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          // 1fs = 1.36
          // 1h = 6.4
          // 1w = 4.1
          fontSize: 33.sp,
        ),
      ),
    );
  }

  TextButton _forgotPasswordButton(context) {
    return TextButton(
      onPressed: () {
        Push(context, screen: ForgotPassword());
      },
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: White,
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
        ),
      ),
    );
  }

  TextFormField _passwordTextField() {
    return TextFormField(
      style: _inputColor(),
      obscureText: true,
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.lock,
        labelText: 'Password',
      ),
    );
  }

  TextFormField _usernameTextField() {
    return TextFormField(
      style: _inputColor(),
      cursorColor: White,
      decoration: borderDecoration(
        icon: Icons.person,
        labelText: 'Username',
      ),
    );
  }

  TextStyle _inputColor() => TextStyle(color: White);

  Container _dontHaveAnAccount() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Red, DarkRed],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.8.w, vertical: 3.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "DON'T HAVE AN ACCOUNT?",
              style: TextStyle(
                color: White,
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
              ),
            ),
            _floatingActionButton(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: DeepRed,
      shape: RoundedRectangleBorder(),
      child: Icon(
        Icons.add,
        size: 35.sp,
      ),
      onPressed: () {
        Push(
          context,
          screen: Registration(),
        );
      },
    );
  }
}
