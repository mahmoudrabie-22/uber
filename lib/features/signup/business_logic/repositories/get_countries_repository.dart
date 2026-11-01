import 'package:uber/features/signup/data/models/country_model.dart';
import 'package:uber/features/signup/data/services/get_countries_web_services.dart';

class GetCountriesRepository {
  final GetCountriesWebServices webServices;
  const GetCountriesRepository({required this.webServices});

  Future<List<CountryModel>> getAllCountries()async
  {
    return webServices.getAllCountries();
  }
}
