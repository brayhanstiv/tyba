import 'package:universities/src/data/services/remote/get_university_service.dart';
import 'package:universities/src/domain/models/universities.dart';
import 'package:universities/src/domain/repositories/universities_respository.dart';

class UniversitiesRespositoryImpl implements UniversitiesRespository {
  final RemoteServices remoteServices;

  UniversitiesRespositoryImpl(this.remoteServices);

  @override
  Future<List<University>> getUniversities() async {
    return remoteServices.getUniversities();
  }
}
