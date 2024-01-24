// ignore: file_names
import 'package:weikert_teste_api/application/helpers/request_mapping.dart';

class UpdateStudentViewModel extends RequestMapping {
  String? id;
  String? name;
  String? phone;

  UpdateStudentViewModel(String dataRequest) : super(dataRequest);

  @override
  void map() {
    id = data['id'];
    name = data['name'];
    phone = data['phone'];
  }
}
