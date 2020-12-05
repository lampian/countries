enum EndPoint {
  all,
  africa,
}

class API {
  static final String host = 'restcountries.eu';

  Uri endpointUri(EndPoint endPoint) => Uri(
        scheme: 'https',
        host: host,
        path: _paths[endPoint],
      );

  static Map<EndPoint, String> _paths = {
    EndPoint.all: '/rest/v2/all',
    EndPoint.africa: '/rest/v2/region/africa',
  };
}
