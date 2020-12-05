import 'package:countries_info/model/country_model.dart';
import 'package:get/get.dart';

class CountryDetailController extends GetxController {
  var _country = CountryModel(
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
          code: 'NC')
      .obs;

  set country(CountryModel newCountry) {
    _country.value = newCountry;
    update();
  }

  CountryModel get country => _country.value;

  String getDescription() {
    return '${country.name} covers an area of '
        '${country.area} km² and has a population of '
        '${country.population} - the nation has a Gini coefficient of '
        '${country.giniCoefficient}. A resident of '
        '${country.name} is called an '
        '${country.demonym}. The main currency accepted as legal tender is the '
        '${country.currency} which is expressed with the symbol '
        '\'${country.currencySymbol}\'';
  }
}
