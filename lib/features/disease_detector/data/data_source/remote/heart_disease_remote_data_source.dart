import 'dart:convert';

import 'package:health_care_application/features/disease_detector/data/models/heart_disease_input.dart';
import 'package:health_care_application/utils/utils.dart';
import 'package:http/http.dart' as http;

class HeartDiseaseRemoteDataSource {

  final String apiUrl = 'https://heart-api-4t43.onrender.com/predict';

  Future<String> predictHeartDisease(HeartDiseaseInput inputData) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(inputData.toJson()),
      );

      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['Heart Disease Prediction'];
      } else {
        throw Exception('Failed to predict heart disease');
      }
    } catch (e) {
      Utils.showSnackBar(e.toString());
      throw Exception('Error: $e');
    }
  }
}