import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/core/constants/colors.dart';
import 'package:uber/features/signup/business_logic/get_countries_cubit/get_all_countries_cubit.dart';
import 'package:uber/features/signup/data/models/country_model.dart';

class ChooseCountry extends StatefulWidget {
  const ChooseCountry({super.key, required this.onCountrySelected});
  final ValueChanged<CountryModel> onCountrySelected;
  @override
  State<ChooseCountry> createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  CountryModel? selectedCountry;

  @override
  void initState() {
    super.initState();
    context.read<GetAllCountriesCubit>().getAllCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4 ),
      decoration: BoxDecoration(
        color: myGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: BlocBuilder<GetAllCountriesCubit, GetAllCountriesState>(
        builder: (context, state) {
          if (state is GetAllCountriesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetAllCountriesSuccess) {
            final countries = state.countries;

            selectedCountry ??= countries.first;

            return DropdownButton<CountryModel>(
              dropdownColor: Colors.white,
              itemHeight: null,
              menuWidth: double.infinity,
              value: selectedCountry,
              underline: const SizedBox(),
              items: countries.map((country) {
                return DropdownMenuItem<CountryModel>(
                  value: country,
                  child: Row(
                    children: [
                      Text(country.flag, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 22),

                      Expanded(
                        child: Text(
                          country.name,
                          style: const TextStyle(fontSize: 20),
                          softWrap: true,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        '+${country.callingCode}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                );
              }).toList(),
              selectedItemBuilder: (context) {
                return countries.map((country) {
                  return Center(
                    child: Row(
                      children: [
                        Text(
                          country.flag,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
              onChanged: (value) {
                setState(() {
                  widget.onCountrySelected(value!);
                  selectedCountry = value;
                });
              },
            );
          }

          return const Icon(Icons.error, color: Colors.red);
        },
      ),
    );
  }
}
