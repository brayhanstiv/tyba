import '../models/universities.dart';

abstract class UniversitiesRespository {
  Future<List<University>> getUniversities();
}
