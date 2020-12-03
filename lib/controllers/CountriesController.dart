import 'package:countries_info/model/country_model.dart';
import 'package:get/get.dart';

class CountriesController extends GetxController {
  var _aText = '''List of countries.
Click to navigate to country detail.'''
      .obs;
  String get aText => _aText.string;

  // flag icon za name capital

  var countries = List<CountryModel>().obs;

  final noCountry = CountryModel(
      area: 0,
      borders: null,
      capital: 'No captial available',
      currency: 'None',
      currencySymbol: '-',
      demonym: '-',
      flagUrl: null,
      giniCoefficient: 0.0,
      languages: null,
      name: 'No country available',
      population: 0,
      subRegion: '-',
      code: 'NC');

  @override
  void onInit() {
    countries.add(noCountry);
    countries.add(noCountry);
    super.onInit();
  }
}
