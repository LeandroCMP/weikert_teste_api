// ignore: file_names
import 'package:weikert_teste_api/application/helpers/request_mapping.dart';

class DeleteStudentViewModel extends RequestMapping {
  String? id;

  DeleteStudentViewModel(String dataRequest) : super(dataRequest);

  @override
  void map() {
    id = data['id'];
  }
}
