import 'package:fibro_pred/Utils/WebService/WebService.dart';
import 'package:http/http.dart';

import 'WebServicesVariables.dart';

class AuthService {
  static String url = WebService.getUrl(WebServicesVariables.AUTH);
  static Future<Response> login() async {
    return Response("no donde", 200);

    return WebService(baseUrl: url).get("/login", false);
  }

  static Future<Response> register() async {
    return WebService(baseUrl: url).post("/register", {}, false);
  }
}
