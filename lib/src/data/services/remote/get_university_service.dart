// Packages
import 'dart:convert';

import 'package:http/http.dart' as http;

// Models
import '../../../domain/models/universities.dart';

class RemoteServices {
  Future<List<University>> getUniversities() async {
    Uri uri = Uri.parse(
        'https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json');

    http.Response response = await http.get(uri);
    List data = json.decode(response.body);
    List<University> universities =
        data.map((x) => University.fromJson(x)).toList();
    return universities;
  }
}
