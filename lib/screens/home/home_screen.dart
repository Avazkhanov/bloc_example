import 'package:bloc_example/cubits/countries/countries_cubit.dart';
import 'package:bloc_example/data/models/countries_model.dart';
import 'package:bloc_example/data/models/form_status.dart';
import 'package:bloc_example/utils/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<CountriesCubit>().state;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Countries",
            style: AppStyle.interBold.copyWith(fontSize: 24.sp)),
      ),
      body: cubit.formsStatus == FormsStatus.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: cubit.countries.length,
              itemBuilder: (context, index) {
                CountriesModel country = cubit.countries[index];
                return ListTile(
                  leading: Text("+ ${country.phone}",style: AppStyle.interMedium.copyWith(fontSize: 14.sp)),
                  title: Text(country.name,
                      style: AppStyle.interBold.copyWith(fontSize: 16.sp)),
                  subtitle: Text(country.capital,
                      style: AppStyle.interMedium.copyWith(fontSize: 14.sp)),
                  trailing: Text(country.emoji,
                      style: AppStyle.interBold.copyWith(fontSize: 22.sp)),
                );
              },
            ),
    );
  }
}
