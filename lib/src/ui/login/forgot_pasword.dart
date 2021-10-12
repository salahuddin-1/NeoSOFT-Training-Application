import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/blocs_api/forgot_password_BLOC.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/ui/login/login.dart';
import 'package:neosoft_training_application/src/validation/registration_validation.dart';
import 'package:neosoft_training_application/src/widgets/toast.dart';
import '/src/constants/colors.dart';
import '/src/widgets/background_gradient.dart';
import '/src/widgets/login_register_button.dart';
import '/src/widgets/textfield_border_decoration.dart';
import 'package:sizer/sizer.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController _emailCOntrl;
  final _formKey = GlobalKey<FormState>();
  late ForgotPasswordBLOC1 _forgotPasswordBLOC1;

  @override
  void initState() {
    _emailCOntrl = new TextEditingController();

    _forgotPasswordBLOC1 = ForgotPasswordBLOC1();
    super.initState();
  }

  @override
  void dispose() {
    _emailCOntrl.dispose();

    _forgotPasswordBLOC1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
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
                        _emailTextField(),
                        SizedBox(height: 6.h),
                        _forgotPasswordButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _title() {
    return Container(
      child: Text(
        'NeoSTORE',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 33.sp,
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        controller: _emailCOntrl,
        validator: (val) => ValidationRegister.email(val!),
        style: _inputColor(),
        cursorColor: White,
        decoration: borderDecoration(
          icon: Icons.email,
          labelText: 'Email',
        ),
      ),
    );
  }

  TextStyle _inputColor() => TextStyle(color: White);

  BoxDecoration _boxDecoration() => BoxDecoration(gradient: gradient());

  _forgotPasswordButton() {
    return StreamBuilder<bool>(
      stream: _forgotPasswordBLOC1.indicatorInstance.stream,
      builder: (context, snapshot) {
        var isLoading = snapshot.data;

        return LoginRegisterButton(
          title: 'SUBMIT',
          onPressed: () {
            _submit();
          },
          isLoading: snapshot.hasData ? isLoading! : false,
        );
      },
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Text("Forgot password"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Pop(context),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _forgotPasswordBLOC1.forgotPassword(_emailCOntrl.text.trim());

      _forgotPasswordBLOC1.streamCntrl.listen(
        (response) {
          if (response.status == Status.COMPLETED) {
            ShowToast.toast(response.data!.userMsg!, context, 4);

            PushAndRemoveUntil(
              context,
              screen: LoginScreen(),
            );
          } else {
            ShowToast.toast(response.message!, context, 4);
          }
        },
      );
    }
  }
}
