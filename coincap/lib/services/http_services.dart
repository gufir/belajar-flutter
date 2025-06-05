import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/app_config.dart';

class HttpServices {
  final Dio dio = Dio();

  AppConfig? _appConfig;
  String? _base_url;

  HttpServices() {
    _appConfig = GetIt.instance<AppConfig>();
    _base_url = _appConfig!.COIN_API_BASE_URL;
  }

  Future<Response?> get(String _path) async {
    try {
      String _url = "$_base_url$_path";
      Response? _response = await dio.get(_url);
      return _response;
    } catch (e) {
      print("HTTPServices: Error in GET request: $e");
    }
  }
}
