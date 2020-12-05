import 'dart:convert';

import 'package:countries_info/model/country_model.dart';
import 'package:countries_info/services/api.dart';
//import 'package:countries_info/services/sample_data.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService(this.api);
  final API api;

  Future<List<CountryModel>> getEndPointData(EndPoint endPoint) async {
    final uri = api.endpointUri(endPoint);
    print('uri: $uri');
    final response = await http.get(uri.toString());
    if (response.statusCode == 200) {
      final List<dynamic> data = await jsonDecode(response.body); //testData);
      var countryList = List<CountryModel>();
      if (data.isNotEmpty) {
        data.forEach((element) {
          countryList.add(CountryModel.fromJson(element));
        });
      }
      return countryList;
    } else {
      print('${response.reasonPhrase}');
      throw response;
    }
  }
}
