import 'dart:convert';

import 'package:health_care_application/features/disease_detector/data/models/diabetes_input.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/utils.dart';

class DiabetesDiseaseRemoteDataSource {

  final String apiUrl = 'https://diabetics-94b6.onrender.com/predict';

  Future<String> predictDiabetes(DiabetesInput input) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(input.toJson())
      );

      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['prediction'];
      } else {
        throw Exception('Failed to predict heart disease');
      }
    } catch (e) {
      Utils.showSnackBar(e.toString());
      throw Exception('Error: $e');
    }
  }
}