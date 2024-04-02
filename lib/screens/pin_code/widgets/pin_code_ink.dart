import 'package:bloc_example/cubits/pin_code/pin_code_cubit.dart';
import 'package:bloc_example/screens/home/home_screen.dart';
import 'package:bloc_example/utils/styles/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinCodeInk extends StatelessWidget {
  const PinCodeInk({super.key, required this.number});

  final String number;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 60.h,
      width: 60.w,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 8),
            ),
          ]),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          PinCodeCubit pinCodeCubit = context.read<PinCodeCubit>();
          if (pinCodeCubit.pin.isEmpty) {
            if (pinCodeCubit.state.pinCode.length == 3) {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }
            pinCodeCubit.setButton(number);
          } else {
            if (pinCodeCubit.state.pinCode.length < 4) {
              pinCodeCubit.setButton(number);
            } else if (pinCodeCubit.state.pinCode.length >= 4) {
              bool isSame = pinCodeCubit.checkPassword();
              debugPrint("Check Password $isSame");
              if (isSame) {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     backgroundColor: Colors.red,
                    content:  Text(
                      "Wrong password !",
                      style: AppStyle.interBold.copyWith(fontSize: 22.sp,color: Colors.white)
                    ),
                  ),
                );
              }
            }
          }
        },
        child: Center(
          child: Text(
            number,
            style: AppStyle.interBold.copyWith(fontSize: 22.sp),
          ),
        ),
      ),
    );
  }
}
