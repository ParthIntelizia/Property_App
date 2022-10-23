import 'package:flutter/cupertino.dart';
import 'package:luxepass/constants/constant_colors.dart';

class SquareBulletPoints extends StatelessWidget{
  const SquareBulletPoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 10.0,
      width: 10.0,
      decoration:  const BoxDecoration(
        color: ConstColors.darkColor,
        shape: BoxShape.rectangle,
      ),
    );
  }
}