part of 'get_all_countries_cubit.dart';

@immutable
sealed class GetAllCountriesState {}

final class GetAllCountriesInitial extends GetAllCountriesState {}

final class GetAllCountriesSuccess extends GetAllCountriesState {
  final List<CountryModel> countries;

  new({required this.countries});
}

final class GetAllCountriesLoading extends GetAllCountriesState {}

final class GetAllCountriesFailure extends GetAllCountriesState {
  final String error;

  new({required this.error});
}
