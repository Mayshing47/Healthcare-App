import 'package:flutter/material.dart';
import 'package:health_care_application/features/doctor/data/models/doctor.dart';
import 'package:health_care_application/features/doctor/domain/respository/doctor_repository.dart';

class DoctorProvider extends ChangeNotifier {
  final DoctorRepository _doctorRepository;

  DoctorProvider({required DoctorRepository doctorRepository})
    : _doctorRepository = doctorRepository;

  Future<List<Doctor>> fetchDoctors() async {
    final doctors =  await _doctorRepository.fetchDoctors();
    return doctors;
  }
}