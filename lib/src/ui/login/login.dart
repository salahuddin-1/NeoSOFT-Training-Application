import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/blocs_api/login_BLOC.dart';
import 'package:neosoft_training_application/src/models/login_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/ui/registration/registraton.dart';
import 'package:neosoft_training_application/src/widgets/background_gradient.dart';
import 'package:neosoft_training_application/src/widgets/login_register_button.dart';
import 'package:neosoft_training_application/src/widgets/textfield_border_decoration.dart';
import '/src/constants/colors.dart';
import 'package:sizer/sizer.dart';

import 'forgot_pasword.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameCntrl;
  late final TextEditingController _passwordCntrl;
  late final LoginBLOC _loginBLOC;

  @override
  void initState() {
    _usernameCntrl = new TextEditingController();
    _passwordCntrl = new TextEditingController();

    _loginBLOC = LoginBLOC(context);

    super.initState();
  }

  @override
  void dispose() {
    _usernameCntrl.dispose();
    _passwordCntrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        decoration: _boxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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
                        _loginButton(),
                        SizedBox(height: 1.5.h),
                        _forgotPasswordButton(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _dontHaveAnAccount(),
          ],
        ),
      ),
    );
  }

  _login() {
    final loginModel = new LoginModel(
      email: _usernameCntrl.text.trim(),
      password: _passwordCntrl.text.trim(),
    );

    _loginBLOC.login(loginModel);
  }

  StreamBuilder<bool> _loginButton() {
    return StreamBuilder<bool>(
      stream: _loginBLOC.circularProgressIntance.stream,
      initialData: false,
      builder: (context, snapshot) {
        var isLoading = snapshot.data!;
        return LoginRegisterButton(
          title: 'LOGIN',
          onPressed: _login,
          isLoading: isLoading,
        );
      },
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(gradient: gradient());

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
        Push(
          context,
          screen: ForgotPassword(),
        );
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
      controller: _passwordCntrl,
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
      controller: _usernameCntrl,
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
