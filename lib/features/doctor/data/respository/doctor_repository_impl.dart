import 'package:health_care_application/features/doctor/data/data_source/remote/doctor_remote_data_source.dart';
import 'package:health_care_application/features/doctor/domain/respository/doctor_repository.dart';
import '../models/doctor.dart';

class DoctorRepositoryImpl extends DoctorRepository {
  final DoctorRemoteDataSource _doctorRemoteDataSource;

  DoctorRepositoryImpl({
    required DoctorRemoteDataSource doctorRemoteDataSource,
  }) : _doctorRemoteDataSource = doctorRemoteDataSource;

  @override
  Future<List<Doctor>> fetchDoctors() async {
    return await _doctorRemoteDataSource.fetchDoctors();
  }
}
