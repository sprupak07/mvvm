import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _signupFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
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
                    context, emailFocusNode, passwordFocusNode),
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
                    controller: _passwordController,
                    focusNode: passwordFocusNode,
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
                    if (_signupFormKey.currentState!.validate()) {
                      Map data = {
                        'email': _emailController.text.toString(),
                        'password': _passwordController.text.toString(),
                      };

                      authViewModel.registerApi(
                        data,
                        context,
                      );
                      if (kDebugMode) {
                        print('Api Hit');
                      }
                    }
                  },
                  title: 'SignUp',
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.login);
                  },
                  child: const Text("Already have account? Login")),
            ],
          ),
        ),
      ),
    );
  }
}
