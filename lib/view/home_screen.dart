import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userPref = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'You are logged in',
              style: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 20),
          RoundButton(
            title: "Logout",
            height: 40,
            width: 150,
            onPressed: () {
              userPref.remove().then(
                  (value) => Navigator.pushNamed(context, RoutesName.login));
            },
          )
        ],
      ),
    );
  }
}
