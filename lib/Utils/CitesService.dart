import 'package:http/http.dart';

import '../Objects/Cita.dart';
import 'WebService/WebService.dart';

class CitesService {
  static String url = "127.0.0.1:8000/citas/";

  static Future<Response> add({required Cita cita}) async {
    return Response("no donde", 200);
  }

  static Future<Response> getAll() async {
    return Response("no donde", 200);

    return WebService(baseUrl: url).get("/get", false);
  }

  static get(int id) {
    return WebService(baseUrl: url).get("/get/$id", false);
  }
}
