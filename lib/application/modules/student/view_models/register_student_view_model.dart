import 'package:weikert_teste_api/application/helpers/request_mapping.dart';

class RegisterStudentViewModel extends RequestMapping {
  String? name;
  String? phone;

  RegisterStudentViewModel(String dataRequest) : super(dataRequest);

  @override
  void map() {
    name = data['name'];
    phone = data['phone'];
  }
}
