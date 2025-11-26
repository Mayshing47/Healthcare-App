

import 'package:health_care_application/features/disease_detector/data/data_source/remote/heart_disease_remote_data_source.dart';

import '../../domain/repository/heart_disease_repository.dart';
import '../models/heart_disease_input.dart';

class HeartDiseaseRepositoryImpl extends HeartDiseaseRepository {

  final HeartDiseaseRemoteDataSource _heartDiseaseRemoteDataSource;
  HeartDiseaseRepositoryImpl({required HeartDiseaseRemoteDataSource heartDiseaseRemoteDataSource}) : _heartDiseaseRemoteDataSource = heartDiseaseRemoteDataSource;

  @override
  Future<String> predictHeartDisease(HeartDiseaseInput inputData) async {
    return await _heartDiseaseRemoteDataSource.predictHeartDisease(inputData);
  }


}