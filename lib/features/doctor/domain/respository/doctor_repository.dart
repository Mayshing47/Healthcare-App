

import 'package:health_care_application/features/doctor/data/models/doctor.dart';

abstract class DoctorRepository {

  Future<List<Doctor>> fetchDoctors();
}