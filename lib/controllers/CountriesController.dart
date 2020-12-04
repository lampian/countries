import 'package:countries_info/model/country_model.dart';
import 'package:countries_info/services/api.dart';
import 'package:countries_info/services/api_service.dart';
import 'package:get/get.dart';

class CountriesController extends GetxController {
  CountriesController() {
    api = API();
    apiService = ApiService(api);
  }

  var _aText = '''List of countries.Click to navigate to country detail.'''.obs;
  String get aText => _aText.string;
  API api;
  ApiService apiService;

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
  Future<void> onInit() async {
    var retList = await apiService.getEndPointData(EndPoint.africa);
    retList.forEach((element) {
      countries.add(element);
    });

    super.onInit();
  }

  CountryModel getCountryDetail(String countryName) {
    return countries.firstWhere((element) => element.name == countryName);
  }

  List<FlagModel> getBorderFlagUrl(List<String> borders) {
    var borderInfo = List<FlagModel>();
    //var flagInfo = FlagModel();
    borders.forEach((element) {
      var country = CountryModel();
      try {
        country = countries.firstWhere((x) => x.code == element);
      } catch (e) {
        country.name = element;
        country.flagUrl = 'null';
      }
      borderInfo.add(FlagModel(name: country.name, flagUrl: country.flagUrl));
    });
    return borderInfo;
  }

  String getDescription(CountryModel country) {
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
