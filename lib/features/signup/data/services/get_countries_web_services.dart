import 'package:dio/dio.dart';
import 'package:uber/core/constants/strings.dart';
import 'package:uber/features/signup/data/models/country_model.dart';

class GetCountriesWebServices {
  Future<List<CountryModel>> getAllCountries() async {
    final response = await Dio().get(getAllFlags);
    final countries = (response.data as List)
        .map((country) => CountryModel.fromJson(country))
        .toList();
    return countries;
  }
}
