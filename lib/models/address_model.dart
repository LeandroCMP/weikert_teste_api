import 'dart:convert';

class AddressModel {
  final String zipCode;
  final String city;
  final String uf;
  final String neighborhood;
  AddressModel({
    required this.zipCode,
    required this.city,
    required this.uf,
    required this.neighborhood,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'zipCode': zipCode,
      'city': city.toUpperCase(),
      'uf': uf.toUpperCase(),
      'neighborhood': neighborhood.toUpperCase(),
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      zipCode: map['zipCode'] ?? "",
      city: map['city'] ?? "",
      uf: map['uf'] ?? "",
      neighborhood: map['neighborhood'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressModel(zipCode: $zipCode, city: $city, uf: $uf, neighborhood: $neighborhood)';
  }
}
