import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uber/features/signup/business_logic/repositories/get_countries_repository.dart';
import 'package:uber/features/signup/data/models/country_model.dart';

part 'get_all_countries_state.dart';

class GetAllCountriesCubit extends Cubit<GetAllCountriesState> {
  GetAllCountriesCubit({required this._getCountriesRepository})
    : super(GetAllCountriesInitial());

  final GetCountriesRepository _getCountriesRepository;
  List<CountryModel> _countries = [];
  Future<void> getAllCountries() async {
    emit(GetAllCountriesLoading());
    try {
      _countries = await _getCountriesRepository.getAllCountries();
      emit(GetAllCountriesSuccess(countries: _countries));
    } catch (e) {
      emit(
        GetAllCountriesFailure(error: "There was an error + ${e.toString()}"),
      );
    }
  }
}
