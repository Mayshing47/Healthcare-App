import 'package:health_care_application/features/disease_detector/data/data_source/remote/symptom_to_disease_remote_data_source.dart';
import 'package:health_care_application/features/disease_detector/data/models/symptom_to_disease_input.dart';
import 'package:health_care_application/features/disease_detector/domain/repository/symptom_to_disease_repository.dart';

class SymptomToDiseaseRepositoryImpl extends SymptomToDiseaseRepository {

  final SymptomToDiseaseRemoteDataSource _symptomToDiseaseRemoteDataSource;

  SymptomToDiseaseRepositoryImpl(
      {required SymptomToDiseaseRemoteDataSource symptomToDiseaseRemoteDataSource})
      : _symptomToDiseaseRemoteDataSource = symptomToDiseaseRemoteDataSource;

  @override
  Future<String> predictDiseaseFromSymptoms(SymptomToDiseaseInput input) async {
    return await _symptomToDiseaseRemoteDataSource.predictDiseaseFromSymptoms(input);
  }
}