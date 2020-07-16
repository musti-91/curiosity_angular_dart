import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:http/http.dart';

@Injectable()
class HelperService {
  Exception simplifyError(dynamic e) {
    return throw Exception('Client Error [cause: ${e.toString()}]');
  }

  dynamic extractData(Response response) {
    return jsonDecode(response.body)['data'];
  }
}
