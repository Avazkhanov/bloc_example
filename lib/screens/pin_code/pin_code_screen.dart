import 'package:bloc_example/cubits/pin_code/pin_code_cubit.dart';
import 'package:bloc_example/screens/home/home_screen.dart';
import 'package:bloc_example/screens/pin_code/widgets/pin_code_ink.dart';
import 'package:bloc_example/services/local_auth.dart';
import 'package:bloc_example/utils/styles/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key, required this.isFirst});

  final bool isFirst;

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  bool auth = false;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<PinCodeCubit>().state;
    var provider = context.watch<PinCodeCubit>();
    List<String> firstNumbers = ["1", "2", "3"];
    List<String> secondNumbers = ["4", "5", "6"];
    List<String> thirdNumbers = ["7", "8", "9"];
    debugPrint("pin code ${widget.isFirst}");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(state.pinCode.isEmpty? "Enter your password":"Enter a new password",
                    style: AppStyle.interBold.copyWith(fontSize: 22.sp))),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Icon(
                    CupertinoIcons.circle_fill,
                    size: 30.sp,
                    color: state.pinCode.length > index
                        ? Colors.green
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(firstNumbers.length,
                    (index) => PinCodeInk(number: firstNumbers[index]))),
            SizedBox(height: 15.h),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(secondNumbers.length,
                    (index) => PinCodeInk(number: secondNumbers[index]))),
            SizedBox(height: 15.h),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(thirdNumbers.length,
                    (index) => PinCodeInk(number: thirdNumbers[index]))),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                widget.isFirst
                    ? IconButton(
                        onPressed: () async {
                          bool enteredFinger = await LocalAuth.authenticate();
                          if (enteredFinger) {
                            if(!context.mounted) return;
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.fingerprint,
                          size: 40.sp,
                        ),
                      )
                    : SizedBox(width: 45.w),
                const PinCodeInk(number: '0'),
                IconButton(
                  onPressed: () {
                    context.read<PinCodeCubit>().deleteButton();
                  },
                  icon: Icon(
                    CupertinoIcons.delete_left_fill,
                    size: 30.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }
}
