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

  //list used by pages and is filtered according to the search string
  var countries = List<CountryModel>().obs;
  //original list of countries with their information - does not change
  // once loaded
  final original = List<CountryModel>();

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

  // search control that also updates the list of countries
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

  //return details of country using original list not the filtered
  //list as the request can originate from neigbouring country selection
  CountryModel getCountryDetail(String countryName) {
    try {
      return original.firstWhere((element) => element.name == countryName);
    } catch (e) {
      print(e);
      return noCountry;
    }
  }

  // return list of flags from neighbouring coutries using original list
  // because borders may/will contain coutries outside filtered list countries
  List<FlagModel> getBorderFlagUrl(List<String> borders) {
    var borderInfo = List<FlagModel>();
    //var flagInfo = FlagModel();
    borders?.forEach((element) {
      var country = CountryModel();
      try {
        country = original.firstWhere((x) => x.borderCode == element);
      } catch (e) {
        country.name = element;
        country.flagUrl = 'null';
      }
      borderInfo.add(FlagModel(
        name: country.name,
        flagUrl: country.flagUrl,
        borderCode: country.code,
      ));
    });
    return borderInfo;
  }
}
