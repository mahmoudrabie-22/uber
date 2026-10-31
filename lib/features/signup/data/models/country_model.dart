class CountryModel {
  final String name;
  final String flag;
  final String callingCode;

  CountryModel({
    required this.name,
    required this.flag,
    required this.callingCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'],
      flag: json['flag'],
      callingCode: json['callingCodes'][0],
    );
  }
}