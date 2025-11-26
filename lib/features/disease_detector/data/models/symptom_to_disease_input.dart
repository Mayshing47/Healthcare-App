

class SymptomToDiseaseInput {
  final String firstSymptom;
  final String secondSymptom;
  final String thirdSymptom;

  SymptomToDiseaseInput({
    required this.firstSymptom,
    required this.secondSymptom,
    required this.thirdSymptom,
  });

  Map<String, dynamic> toJson() {
    return {
      "Symptom1": firstSymptom,
      "Symptom2": secondSymptom,
      "Symptom3": thirdSymptom,
    };
  }
}