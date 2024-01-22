// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weikert_teste_api/application/helpers/request_mapping.dart';

class RecoveryPasswordViewModel extends RequestMapping {
  String? email;

  RecoveryPasswordViewModel(String dataRequest) : super(dataRequest);

  @override
  void map() {
    email = data['email'];
  }
}
