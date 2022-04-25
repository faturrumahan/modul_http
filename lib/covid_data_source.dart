import 'package:modul_http/network.dart';

class CovidDataSource {
  static CovidDataSource instance = CovidDataSource();
  Future<Map<String, dynamic>> loadCountries() {
    return BaseNetwork.get("countries");
  }
}