

import 'package:health_care_application/features/disease_detector/data/data_source/remote/diabetes_disease_remote_data_source.dart';
import 'package:health_care_application/features/disease_detector/data/models/diabetes_input.dart';
import 'package:health_care_application/features/disease_detector/domain/repository/diabetes_disease_repository.dart';

class DiabetesDiseaseRemoteRepositoryImpl extends DiabetesDiseaseRepository {

  final DiabetesDiseaseRemoteDataSource _diabetesDiseaseRemoteDataSource;
  DiabetesDiseaseRemoteRepositoryImpl({required DiabetesDiseaseRemoteDataSource diabetesDiseaseRemoteDataSource}) : _diabetesDiseaseRemoteDataSource = diabetesDiseaseRemoteDataSource;

  @override
  Future<String> predictDiabetes(DiabetesInput input) async {
    return await _diabetesDiseaseRemoteDataSource.predictDiabetes(input);
  }


}