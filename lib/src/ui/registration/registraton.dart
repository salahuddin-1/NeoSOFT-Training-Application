import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/blocs/radio_buttons_bloc.dart';
import 'package:neosoft_training_application/src/blocs_api/register_BLOC.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/models/user_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/validation/registration_validation.dart';
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
  final _formKey = GlobalKey<FormState>();

  late final RadioButtonsBloc _radioBloc;
  late final RegisterBLOC _registerBLOC;

  late final TextEditingController _firstNameCntrl;
  late final TextEditingController _lastNameCntrl;
  late final TextEditingController _emailCntrl;
  late final TextEditingController _passwordCntrl;
  late final TextEditingController _confirmPassCntrl;
  late final TextEditingController _phoneNoCntrl;

  @override
  void initState() {
    _radioBloc = new RadioButtonsBloc();
    _registerBLOC = new RegisterBLOC(context);

    _firstNameCntrl = new TextEditingController();
    _lastNameCntrl = new TextEditingController();
    _emailCntrl = new TextEditingController();
    _passwordCntrl = new TextEditingController();
    _confirmPassCntrl = new TextEditingController();
    _phoneNoCntrl = new TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _radioBloc.dispose();
    _registerBLOC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Container(
        decoration: _boxDecoration(),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  _registerButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<bool> _registerButton() {
    return StreamBuilder<bool>(
      stream: _registerBLOC.circularProgressIntance.stream,
      initialData: false,
      builder: (context, snapshot) {
        var isLoading = snapshot.data!;
        return LoginRegisterButton(
          title: 'REGISTER',
          onPressed: _register,
          isLoading: isLoading,
        );
      },
    );
  }

  _register() async {
    if (_formKey.currentState!.validate() && _radioBloc.iAgree) {
      var model = new RegisterModel(
        firstName: _firstNameCntrl.text.trim(),
        lastName: _lastNameCntrl.text.trim(),
        email: _emailCntrl.text.trim(),
        password: _passwordCntrl.text.trim(),
        confirmPassword: _confirmPassCntrl.text.trim(),
        gender: _radioBloc.value,
        phoneNo: _phoneNoCntrl.text.trim(),
      );
      _registerBLOC.register(model);
    }
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
      controller: _firstNameCntrl,
      validator: (val) => ValidationRegister.firstName(val!),
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
      controller: _lastNameCntrl,
      validator: (val) => ValidationRegister.lastName(val!),
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
      controller: _emailCntrl,
      validator: (val) => ValidationRegister.email(val!),
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
      controller: _passwordCntrl,
      validator: (val) => ValidationRegister.password(val!),
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
      controller: _confirmPassCntrl,
      validator: (val) => ValidationRegister.conPassword(
        val!,
        _passwordCntrl.text.trim(),
      ),
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
      controller: _phoneNoCntrl,
      validator: (val) => ValidationRegister.phoneNumber(val!),
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
