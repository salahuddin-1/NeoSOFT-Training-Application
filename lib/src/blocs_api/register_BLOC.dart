import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/blocs/circular_progress_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/get_list_cart_items_BLOC.dart';
import 'package:neosoft_training_application/src/models/user_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/register_api.dart';
import 'package:neosoft_training_application/src/resources/shared_pref.dart';
import 'package:neosoft_training_application/src/ui/homescreen/homescreen.dart';
import 'package:neosoft_training_application/src/widgets/toast.dart';

class RegisterBLOC {
  BuildContext? _context;

  late final CircularProgressBLOC _circularProgressBLOC;

  // CONSTRUCTOR
  RegisterBLOC(BuildContext context) {
    this._context = context;
    _circularProgressBLOC = new CircularProgressBLOC();
  }

  void register(RegisterModel registerModel) async {
    // SHOW LOADING
    _circularProgressBLOC.sink.add(true);

    try {
      var response = await RegisterAPI.registerUser(registerModel);

      if (response.status == 200) {
        PushAndRemoveUntil(
          _context!,
          screen: BlocProvider.value(
            value: GetListCartItemsBLOC(),
            child: HomeScreen(
              credentials: {
                'email': registerModel.email,
                'password': registerModel.password,
                'accessToken': response.data!.accessToken!,
              },
            ),
          ),
        );
        // PushAndRemoveUntil(
        //   _context!,
        //   screen: HomeScreen(
        //     credentials: {
        //       'email': registerModel.email,
        //       'password': registerModel.password,
        //       'accessToken': response.data!.accessToken!,
        //     },
        //   ),
        // );
      }
      ShowToast.toast(
        response.userMsg!,
        _context!,
        5,
      );

      SharedPref.saveCredentials(
        registerModel.email!,
        registerModel.confirmPassword!,
        accessToken: response.data!.accessToken!,
      );
    } catch (e) {
      print(e.toString());

      ShowToast.toast(
        "Something went wrong !!",
        _context!,
        4,
      );
    }

    // HIDE LOADING
    _circularProgressBLOC.sink.add(false);
  }

  CircularProgressBLOC get circularProgressIntance => _circularProgressBLOC;

  void dispose() {
    _circularProgressBLOC.dispose();
  }
}
