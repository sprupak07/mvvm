import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    emailFocusNode.dispose();
    passFocusNode.dispose();
    _obsecurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Email';
                  } else if (!value.contains(
                    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                  )) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) => Utils.fieldFocusChange(
                    context, emailFocusNode, passFocusNode),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (BuildContext context, value, child) {
                  return TextFormField(
                    controller: passController,
                    focusNode: passFocusNode,
                    obscureText: _obsecurePassword.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      } else if (!value.contains(RegExp(r''))) {
                        return 'Password must be strong & contain Special Character';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: InkWell(
                          onTap: () {
                            _obsecurePassword.value = !_obsecurePassword.value;
                          },
                          child: Icon(_obsecurePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      hintText: 'Enter your Password',
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: RoundButton(
                  loading: authViewModel.loading,
                  height: 50,
                  width: 200,
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      authViewModel.loginApi(
                        {
                          'email': emailController.text.toString(),
                          'password': passController.text.toString(),
                        },
                        context,
                      );
                      if (kDebugMode) {
                        print('Api Hit');
                      }
                    }
                  },
                  title: 'Login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
