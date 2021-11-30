enum NetworkRoutes {
  // BASE_URL_LOCAL,
  BASE_URL_PROD_ONE,
  BASE_URL_LOCAL_TWO,
}

extension NetwrokRoutesString on NetworkRoutes {
  String get rawValue {
    switch (this) {
      case NetworkRoutes.BASE_URL_PROD_ONE:
        return 'http://94.20.38.107:8002/api/';
        // return 'https://quiz.mominov.site/api/';
      default:
        throw Exception('Routes Not FouND');
    }
  }
}
