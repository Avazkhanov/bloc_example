import 'package:bloc_example/cubits/countries/countries_cubit.dart';
import 'package:bloc_example/cubits/pin_code/pin_code_cubit.dart';
import 'package:bloc_example/data/storage_repository/storage_repository.dart';
import 'package:bloc_example/screens/pin_code/pin_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  StorageRepository.instance;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CountriesCubit()..getCountries()),
        BlocProvider(create: (_) => PinCodeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var isFirst = StorageRepository.getString(key: "pin_code");
    debugPrint("main $isFirst");
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: PinCodeScreen(isFirst: isFirst.isNotEmpty ? true : false),
    );
  }
}
