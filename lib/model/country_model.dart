// South Africa
// covers an area of
// 1221037
// km² and has a population of
// 55653654
//  - the nation has a Gini coefficient of
//  63.1
//  . A resident of South Africa is called a
//  South African
//  . The main currency accepted as legal tender is the
//  South African rand
//   which is expressed with the symbol
//   'R'.

class CountryModel {
  CountryModel({
    this.name,
    this.area,
    this.population,
    this.giniCoefficient,
    this.demonym,
    this.currency,
    this.currencySymbol,
    this.subRegion,
    this.capital,
    this.languages,
    this.borders,
    this.flagUrl,
    this.code,
  });
  String name;
  int area;
  int population;
  double giniCoefficient;
  String demonym;
  String currency;
  String currencySymbol;
  String subRegion;
  String capital;
  List<LanguageModel> languages;
  List<String> borders;
  String flagUrl;
  String code;

  CountryModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'].toString();
  }
}

class LanguageModel {
  String nativeName;
  String name;
  LanguageModel({this.name, this.nativeName});
}
