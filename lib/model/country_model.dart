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
  double area;
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
  String borderCode;

  CountryModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    area = json['area'];
    population = json['population'];
    giniCoefficient = json['gini'];
    demonym = json['demonym'];
    currency = json['currencies'][0]['code'];
    currencySymbol = json['currencies'][0]['symbol'];
    subRegion = json['subregion'];
    capital = json['capital'];
    List<dynamic> langList = json['languages'];
    languages = List<LanguageModel>();
    langList.forEach((element) {
      print(element);
      languages.add(
        LanguageModel(
          name: element['name'],
          nativeName: element['nativeName'],
        ),
      );
    });
    List<dynamic> borderList = json['borders'];
    borders = List<String>();
    borderList.forEach((element) {
      print(element);
      borders.add(element);
    });
    flagUrl = json['flag'];
    code = json['alpha2Code'];
    borderCode = json['alpha3Code'];
  }
}

class LanguageModel {
  String nativeName;
  String name;
  LanguageModel({this.name, this.nativeName});
}

class FlagModel {
  String flagUrl;
  String name;
  String borderCode;
  FlagModel({this.flagUrl, this.name, this.borderCode});
}
