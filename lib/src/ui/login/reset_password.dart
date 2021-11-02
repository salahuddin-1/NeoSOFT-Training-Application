import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '/src/blocs_api/reset_password_BLOC.dart';
import '/src/constants/colors.dart';
import '/src/models/reset_password_model.dart';
import '/src/navigation/navigation.dart';
import '/src/resources/api_reponse_generic.dart';
import '/src/validation/reset_password_validation.dart';
import '/src/widgets/background_gradient.dart';
import '/src/widgets/circular_progress.dart';
import '/src/widgets/common_appbar.dart';
import '/src/widgets/textfield_border_decoration.dart';
import '/src/widgets/toast.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

  late final ResetPasswordBLOC _resetPasswordBLOC;

  late TextEditingController _currentPCntrl;
  late TextEditingController _newPCntrl;
  late TextEditingController _confirmPCntrl;

  @override
  void initState() {
    _resetPasswordBLOC = new ResetPasswordBLOC();

    _currentPCntrl = new TextEditingController();
    _newPCntrl = new TextEditingController();
    _confirmPCntrl = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _resetPasswordBLOC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, title: 'Reset Password'),
      body: _body(),
    );
  }

  _body() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          decoration: _boxDecoration(),
          child: ListView(
            padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 20.w),
            children: [
              SizedBox(height: 8.h),
              _title(),
              SizedBox(height: 4.h),
              _currentPasswordTextField(),
              _sizeBox,
              _newPasswordTextField(),
              _sizeBox,
              _confirmPasswordTextField(),
              SizedBox(height: 2.5.h),
              _resetPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }

  Center _title() {
    return Center(
      child: Text(
        'NeoSTORE',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 33.sp,
        ),
      ),
    );
  }

  TextFormField _currentPasswordTextField() {
    return TextFormField(
      controller: _currentPCntrl,
      style: _inputColor(),
      cursorColor: White,
      validator: (val) => ResetPasswordValidation.currentPassword(val!),
      decoration: borderDecoration(
        icon: Icons.lock,
        labelText: 'Current Password',
      ),
    );
  }

  TextFormField _newPasswordTextField() {
    return TextFormField(
      controller: _newPCntrl,
      style: _inputColor(),
      cursorColor: White,
      validator: (val) => ResetPasswordValidation.newPassword(val!),
      decoration: borderDecoration(
        icon: Icons.lock,
        labelText: 'New Password',
      ),
    );
  }

  TextFormField _confirmPasswordTextField() {
    return TextFormField(
      controller: _confirmPCntrl,
      style: _inputColor(),
      cursorColor: White,
      validator: (val1) => ResetPasswordValidation.confirmPassword(
        val1!,
        _newPCntrl.text.trim(),
      ),
      decoration: borderDecoration(
        icon: Icons.lock,
        labelText: 'Confirm Password',
      ),
    );
  }

  Widget _resetPasswordButton() {
    return StreamBuilder<bool>(
      stream: _resetPasswordBLOC.indicatorInstance.stream,
      builder: (context, snapshot) {
        bool isLoading = false;

        if (snapshot.hasData) isLoading = snapshot.data!;

        return MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          onPressed: isLoading ? () => null : _submit,
          height: 7.h,
          minWidth: double.infinity,
          color: White,
          child: isLoading
              ? CircularProgressCustom()
              : Text(
                  'RESET PASSWORD',
                  style: TextStyle(
                    color: Red,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                ),
        );
      },
    );
  }

  TextStyle _inputColor() => TextStyle(color: White);

  SizedBox get _sizeBox => SizedBox(height: 2.h);

  BoxDecoration _boxDecoration() => BoxDecoration(gradient: gradient());

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final resetPasswordModel = ResetPasswordModel(
        currentPassword: _currentPCntrl.text.trim(),
        newPassword: _newPCntrl.text.trim(),
        confNewPass: _confirmPCntrl.text.trim(),
      );

      _resetPasswordBLOC.resetPassword(resetPasswordModel);

      _resetPasswordBLOC.streamCntrl.listen(
        (response) {
          if (response.status == Status.COMPLETED) {
            ShowToast.toast(response.data!.userMsg!, context, 4);

            Pop(context);
            return;
          }

          ShowToast.toast(response.message!, context, 4);
        },
      );
    }
  }
}
