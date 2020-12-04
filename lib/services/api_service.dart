import 'dart:convert';

import 'package:countries_info/model/country_model.dart';
import 'package:countries_info/services/api.dart';
import 'package:countries_info/services/sample_data.dart';

class ApiService {
  ApiService(this.api);
  final API api;

  Future<List<CountryModel>> getEndPointData(EndPoint endPoint) async {
    final uri = api.endpointUri(endPoint);
    print('uri: $uri');
    final List<dynamic> data = await jsonDecode(testData);
    var countryList = List<CountryModel>();
    if (data.isNotEmpty) {
      data.forEach((element) {
        countryList.add(CountryModel.fromJson(element));
      });
    }
    await Future.delayed(Duration(seconds: 2));
    return countryList;
  }
}
