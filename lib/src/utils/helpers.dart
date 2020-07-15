import 'dart:convert';

import 'package:http/http.dart';

class Helper {
  static Exception simplifyError(dynamic e) {
    return Exception('[Server erorr]:cause => ${e.toString()}');
  }

  static dynamic extractData(Response response) {
    return jsonDecode(response.body)['data'];
  }
}
