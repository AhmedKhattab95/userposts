import 'package:flutter/material.dart';
import 'package:topics/src/app/theme/theme_lib.dart';

class PageProgressIndecator extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;

  const PageProgressIndecator({this.backgroundColor = AppColors.white, this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.green)),
      ),
    );
  }
}
