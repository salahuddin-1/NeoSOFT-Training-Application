import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/widgets/error_widget.dart';
import 'package:sizer/sizer.dart';

import '../../blocs_api/get_account_details_BLOC.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../models/account_details_model.dart';
import '../../navigation/navigation.dart';
import '../../resources/api_reponse_generic.dart';
import '../../widgets/background_gradient.dart';
import '../../widgets/circular_progress.dart';
import '../../widgets/common_appbar.dart';
import '../../widgets/textfield_border_decoration.dart';
import '../../inherited_widget/inherited_widget.dart';

import '../login/reset_password.dart';
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

  late final GetAccountDetailsBLOC _getAccountDetailsBLOC;

  @override
  void initState() {
    _firstNameCntrl = new TextEditingController();
    _lasttNameCntrl = new TextEditingController();
    _emailCntrl = new TextEditingController();
    _phoneCntrlCntrl = new TextEditingController();
    _dobCntrl = new TextEditingController();

    _getAccountDetailsBLOC = GetAccountDetailsBLOC();

    super.initState();
  }

  @override
  void dispose() {
    _firstNameCntrl.dispose();
    _lasttNameCntrl.dispose();
    _emailCntrl.dispose();
    _phoneCntrlCntrl.dispose();
    _dobCntrl.dispose();

    _getAccountDetailsBLOC.dispose();
    super.dispose();
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: RefreshIndicator(
        onRefresh: () => _getAccountDetailsBLOC.getAccDetails(),
        color: Red,
        child: StreamBuilder<ApiResponse<GetAccountDetailsResponseModel>>(
          stream: _getAccountDetailsBLOC.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressCustom());

                case Status.COMPLETED:
                  final userData = snapshot.data!.data!.data!.userData;

                  _firstNameCntrl.text = userData!.firstName!;
                  _lasttNameCntrl.text = userData.lastName!;
                  _emailCntrl.text = userData.email!;
                  _phoneCntrlCntrl.text = userData.phoneNo!;
                  _dobCntrl.text = userData.dob ?? '';

                  return _screen();

                case Status.ERROR:
                  return ErrorWidgetCustom(
                    message: snapshot.data!.message!,
                    onPressed: () => _getAccountDetailsBLOC.getAccDetails(),
                  );

                default:
                  return SizedBox.shrink();
              }
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Container _screen() {
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
  }

  MaterialButton _submit() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: _navigate,
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

  void _navigate() {
    Push(
      context,
      screen: GetAccountDetailsBLOCProvider(
        bloc: _getAccountDetailsBLOC,
        child: EditProfile(
          firstName: _firstNameCntrl.text,
          lastName: _lasttNameCntrl.text,
          email: _emailCntrl.text,
          phoneNumber: _phoneCntrlCntrl.text,
          dob: _dobCntrl.text,
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

final body = {
  "status": 200,
  "data": [
    {
      "user_data": {
        "id": 8,
        "role_id": 2,
        "first_name": "",
        "last_name": "",
        "email": "",
        "username": "",
        "profile_pic": "",
        "country_id": "",
        "gender": "",
        "phone_no": "",
        "dob": "",
        "is_active": true,
        "created": "",
        "modified": "",
        "access_token": ""
      },
      "product_categories": [
        {
          "id": 1,
          "name": "Table",
          "icon_image": "",
          "created": "2015-08-11T10:12:02+0000",
          "modified": "2015-08-31T11:32:49+0000"
        },
        {
          "id": 2,
          "name": "Sofa",
          "icon_image": "",
          "created": "2015-08-11T10:12:02+0000",
          "modified": "2015-08-31T11:32:49+0000"
        },
      ],
      "total_carts": 2,
      "total_orders": 2
    }
  ],
  "message": "",
  "user_msg": ""
};

final data = {
  "status": 200,
  "data": {
    "user_data": {
      "id": 3424,
      "role_id": 2,
      "first_name": "Salahuddin",
      "last_name": "Shaikh",
      "email": "salahuddinshaikh16@gmail.com",
      "username": "SalahuddinShaikh",
      "profile_pic": null,
      "country_id": null,
      "gender": "Male",
      "phone_no": 8898911744,
      "dob": null,
      "is_active": true,
      "created": "2021-10-05T06:27:27+0000",
      "modified": "2021-10-12T06:21:59+0000",
      "access_token": "615bf04ef24fb"
    },
    "product_categories": [
      {
        "id": 1,
        "name": "Table",
        "icon_image":
            "http://staging.php-dev.in:8844/trainingapp/uploads/cat_icon_img/thumb/medium/a4340b6e08070902ad7f2838c.jpg",
        "created": " 2015-08-12T08:03:13+0000",
        "modified": " 2015-09-15T09:36:59+0000"
      },
      {
        "id": 2,
        "name": "Chairs",
        "icon_image":
            "http://staging.php-dev.in:8844/trainingapp/uploads/cat_icon_img/thumb/medium/699489da778c514dd6a321587.jpg",
        "created": " 2015-08-12T08:03:21+0000",
        "modified": " 2015-09-09T11:17:34+0000"
      },
      {
        "id": 3,
        "name": "Sofa",
        "icon_image":
            "http://staging.php-dev.in:8844/trainingapp/uploads/cat_icon_img/thumb/medium/e273cd55d0317778efa26078b.jpg",
        "created": "2015-08-12T08:03:28+0000",
        "modified": "2015-09-15T09:37:59+0000",
      }
    ]
  }
};
