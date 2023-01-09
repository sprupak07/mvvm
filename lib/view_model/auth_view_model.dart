import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../repository/auth_repository.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<dynamic> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    try {
      dynamic response = await _myrepo.loginApi(data).then((value) {
        setLoading(false);
        final userPref = Provider.of<UserViewModel>(context, listen: false);
        userPref.saveUser(UserModel(token: value['token'].toString()));

        if (kDebugMode) {
          print(value.toString());
        }

        Utils.toastMassage("Login Successfully");
        Navigator.pushNamed(context, RoutesName.home);
      });

      return response;
    } catch (e) {
      Utils.flushBarErrorMassage(context, e.toString());
      setLoading(false);
      rethrow;
    }
  }

  Future<dynamic> registerApi(dynamic data, BuildContext context) async {
    try {
      setLoading(true);
      dynamic response = await _myrepo.registerApi(data).then((value) {
        setLoading(false);

        if (kDebugMode) {
          print(value.toString());
        }

        Utils.toastMassage("Register Successfully");
      });

      return response;
    } catch (e) {
      Utils.flushBarErrorMassage(context, e.toString());
      setLoading(false);
      rethrow;
    }
  }
}
