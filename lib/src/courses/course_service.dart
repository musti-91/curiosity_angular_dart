import 'package:angular/angular.dart';
import 'package:http/src/client.dart';
import 'package:viewer/src/services/client_service.dart';

@Injectable()
class CourseService extends ClientService {
  CourseService(Client client) : super(client);
}
