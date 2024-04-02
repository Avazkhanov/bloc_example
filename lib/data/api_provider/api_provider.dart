import 'dart:convert';
import 'dart:io';
import 'package:bloc_example/data/models/countries_model.dart';
import 'package:bloc_example/data/my_response.dart';
import 'package:bloc_example/utils/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static Future<MyResponse> getCountries() async {
    try {
      http.Response response = await http.get(Uri.parse(AppConstants.baseUrl));
      if (response.statusCode == HttpStatus.ok) {
        return MyResponse(
          data: (jsonDecode(response.body)['data']['countries'] as List?)
                  ?.map((e) => CountriesModel.fromJson(e))
                  .toList() ??
              [],
        );
      }
      return MyResponse(error: "Noma'lum xatolik");
    } catch (error) {
      return MyResponse(error: error.toString());
    }
  }
}
