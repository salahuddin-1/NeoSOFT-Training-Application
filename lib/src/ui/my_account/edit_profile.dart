import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../blocs_api/update_acc_details_BLOC.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../models/update_acc_details_model.dart';
import '../../navigation/navigation.dart';
import '../../resources/update_acc_details_repo.dart';
import '../login/login.dart';
import '../../widgets/background_gradient.dart';
import '../../widgets/circular_progress.dart';
import '../../widgets/common_appbar.dart';
import '../../widgets/textfield_border_decoration.dart';
import 'package:sizer/sizer.dart';

import '../../inherited_widget/inherited_widget.dart';

class EditProfile extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String dob;

  const EditProfile({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dob,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final TextEditingController _firstNameCntrl;
  late final TextEditingController _lasttNameCntrl;
  late final TextEditingController _emailCntrl;
  late final TextEditingController _phoneCntrlCntrl;
  late final TextEditingController _dobCntrl;

  late final UpdateAccountDetailsBLOC _updateAccountDetailsBLOC;

  @override
  void initState() {
    _firstNameCntrl = new TextEditingController(
      text: widget.firstName,
    );
    _lasttNameCntrl = new TextEditingController(
      text: widget.lastName,
    );
    _emailCntrl = new TextEditingController(
      text: widget.email,
    );
    _phoneCntrlCntrl = new TextEditingController(
      text: widget.phoneNumber,
    );
    _dobCntrl = new TextEditingController(
      text: widget.dob,
    );

    _updateAccountDetailsBLOC = UpdateAccountDetailsBLOC(context);

    super.initState();
  }

  @override
  void dispose() {
    _firstNameCntrl.dispose();
    _lasttNameCntrl.dispose();
    _emailCntrl.dispose();
    _phoneCntrlCntrl.dispose();
    _dobCntrl.dispose();

    super.dispose();
  }

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
      onTap: () => FocusScope.of(context).unfocus(),
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
            _submitButton(),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: _submit,
      height: 7.h,
      minWidth: double.infinity,
      color: White,
      child: _submitText(),
    );
  }

  StreamBuilder<bool> _submitText() {
    return StreamBuilder<bool>(
      stream: _updateAccountDetailsBLOC.indicatorInstance.stream,
      builder: (context, snapshot) {
        bool isLoading = false;

        if (snapshot.hasData) {
          isLoading = snapshot.data!;
        }
        return isLoading
            ? CircularProgressCustom()
            : Text(
                'SUBMIT',
                style: TextStyle(
                  color: Red,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              );
      },
    );
  }

  _submit() {
    final model = UpdateAccountDetailsModel(
      firstName: _firstNameCntrl.text.trim(),
      lastName: _lasttNameCntrl.text.trim(),
      email: _emailCntrl.text.trim(),
      phoneNumber: _phoneCntrlCntrl.text.trim(),
      dob: _dobCntrl.text.trim(),
    );

    _updateAccountDetailsBLOC.update(model);
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
