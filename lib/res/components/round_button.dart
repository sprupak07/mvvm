import 'package:flutter/material.dart';
import 'package:mvvm/res/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final onPressed;

  const RoundButton(
      {super.key, required this.title, this.onPressed, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
