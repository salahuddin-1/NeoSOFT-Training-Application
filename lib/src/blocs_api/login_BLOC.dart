import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/blocs/circular_progress_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/get_list_cart_items_BLOC.dart';
import 'package:neosoft_training_application/src/models/login_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/login_api.dart';
import 'package:neosoft_training_application/src/resources/shared_pref.dart';
import 'package:neosoft_training_application/src/ui/homescreen/homescreen.dart';
import 'package:neosoft_training_application/src/widgets/toast.dart';

class LoginBLOC {
  late BuildContext? _context;
  late final CircularProgressBLOC _circularProgressBLOC;

  LoginBLOC(this._context) {
    _circularProgressBLOC = new CircularProgressBLOC();
  }

  CircularProgressBLOC get circularProgressIntance => _circularProgressBLOC;

  void login(LoginModel loginModel) async {
    _circularProgressBLOC.sink.add(true);

    try {
      final responseModel = await LoginAPI.login(loginModel);

      if (responseModel.status == 200) {
        PushAndRemoveUntil(
          _context!,
          screen: BlocProvider.value(
            value: GetListCartItemsBLOC(),
            child: HomeScreen(
              credentials: {
                'email': loginModel.email,
                'password': loginModel.password,
                'accessToken': responseModel.data!.accessToken!,
              },
            ),
          ),
        );
        // PushAndRemoveUntil(
        //   _context!,
        //   screen: HomeScreen(
        //     credentials: {
        //       'email': loginModel.email,
        //       'password': loginModel.password,
        //       'accessToken': responseModel.data!.accessToken!,
        //     },
        //   ),
        // );

        ShowToast.toast(
          responseModel.userMsg!,
          _context!,
          5,
        );

        SharedPref.saveCredentials(
          loginModel.email,
          loginModel.password,
          accessToken: responseModel.data!.accessToken!,
        );
      }
    } catch (e) {
      ShowToast.toast(
        "Something went wrong !!",
        _context!,
        4,
      );

      print(e.toString());
    }

    _circularProgressBLOC.sink.add(false);
  }

  void dispose() {
    _circularProgressBLOC.dispose();
  }
}
