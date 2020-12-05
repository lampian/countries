import 'package:countries_info/model/country_model.dart';
import 'package:countries_info/services/api.dart';
import 'package:countries_info/services/api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CountriesController extends GetxController {
  CountriesController() {
    api = API();
    apiService = ApiService(api);
  }

  API api;
  ApiService apiService;
  TextEditingController searchTextCntl;
  get searchText => this.searchTextCntl.text;
  set searchText(String value) => this.searchTextCntl.text = value;

  var countries = List<CountryModel>().obs;
  var original = List<CountryModel>();

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
    searchTextCntl = TextEditingController();
    searchText = '';
    var retList = await apiService.getEndPointData(EndPoint.africa);
    retList.forEach((element) {
      countries.add(element);
      original.add(element);
    });
    super.onInit();
  }

  void handleTextInput(String sStr) {
    if (searchText.length > 0) {
      countries.clear();
      var tempList = original
          .where((element) => element.name.toLowerCase().contains(searchText));
      if (tempList.length == 0) {
        original.forEach((x) {
          countries.add(x);
        });
      } else {
        tempList.forEach((x) {
          countries.add(x);
        });
      }
    } else {
      original.forEach((x) {
        countries.add(x);
      });
    }
    update();
  }

  CountryModel getCountryDetail(String countryName) {
    try {
      return countries.firstWhere((element) => element.name == countryName);
    } catch (e) {
      print(e);
      return noCountry;
    }
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
      borderInfo.add(FlagModel(
        name: country.name,
        flagUrl: country.flagUrl,
        code: country.code,
      ));
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
