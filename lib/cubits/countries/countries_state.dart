import 'package:bloc_example/data/models/countries_model.dart';
import 'package:bloc_example/data/models/form_status.dart';

class CountriesState {
  final FormsStatus formsStatus;
  final List<CountriesModel> countries;
  final String status;

  CountriesState({
    required this.formsStatus,
    required this.countries,
    required this.status,
  });

  CountriesState copyWith({
    FormsStatus? formsStatus,
    List<CountriesModel>? countries,
    String? status,
  }) =>
      CountriesState(
        formsStatus: formsStatus ?? this.formsStatus,
        countries: countries ?? this.countries,
        status: status ?? this.status,
      );
}
