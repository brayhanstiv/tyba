// To parse this JSON data, do
//
//     final universities = universitiesFromJson(jsonString);

import 'dart:convert';

List<University> universitiesFromJson(String str) =>
    List<University>.from(json.decode(str).map((x) => University.fromJson(x)));

String universitiesToJson(List<University> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class University {
  University({
    required this.alphaTwoCode,
    required this.domains,
    required this.country,
    this.stateProvince,
    required this.webPages,
    required this.name,
    this.image,
    this.noEstudiantes,
  });

  AlphaTwoCode alphaTwoCode;
  List<String> domains;
  String country;
  String? stateProvince;
  List<String> webPages;
  String name;
  String? image;
  int? noEstudiantes;

  factory University.fromJson(Map<String, dynamic> json) => University(
        alphaTwoCode: alphaTwoCodeValues.map[json["alpha_two_code"]]!,
        domains: List<String>.from(json["domains"].map((x) => x)),
        country: json["country"],
        stateProvince: json["state-province"],
        webPages: List<String>.from(json["web_pages"].map((x) => x)),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "alpha_two_code": alphaTwoCodeValues.reverse[alphaTwoCode],
        "domains": List<dynamic>.from(domains.map((x) => x)),
        "country": country,
        "state-province": stateProvince,
        "web_pages": List<dynamic>.from(webPages.map((x) => x)),
        "name": name,
      };
}

// ignore: constant_identifier_names
enum AlphaTwoCode { US }

final alphaTwoCodeValues = EnumValues({"US": AlphaTwoCode.US});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
