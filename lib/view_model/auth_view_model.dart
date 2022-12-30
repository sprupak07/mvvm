import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/utils/utils.dart';
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
    try {
      setLoading(true);
      dynamic response = await _myrepo.loginApi(data).then((value) {
        setLoading(false);

        print(value.toString());

        Utils.toastMassage("Login Successfully");
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
      dynamic response = await _myrepo.registerApi(data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
