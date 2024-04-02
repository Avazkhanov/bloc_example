import 'package:bloc_example/cubits/countries/countries_state.dart';
import 'package:bloc_example/data/api_provider/api_provider.dart';
import 'package:bloc_example/data/models/countries_model.dart';
import 'package:bloc_example/data/models/form_status.dart';
import 'package:bloc_example/data/my_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit()
      : super(CountriesState(
            formsStatus: FormsStatus.pure, countries: [], status: ""));

  getCountries() async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    MyResponse response = await ApiProvider.getCountries();
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          countries: response.data as List<CountriesModel>,
          formsStatus: FormsStatus.success,
        ),
      );
    }else{
      emit(
        state.copyWith(
          formsStatus: FormsStatus.error,
          status: response.error,
        ),
      );
    }
  }
}
