

class DiabetesInput {
  final int pregnancies;
  final double glucose;
  final double bloodPressure;
  final double skinThickness;
  final double insulin;
  final double bmi;
  final double diabetesPedigreeFunction;
  final int age;

  const DiabetesInput({
    required this.pregnancies,
    required this.glucose,
    required this.bloodPressure,
    required this.skinThickness,
    required this.insulin,
    required this.bmi,
    required this.diabetesPedigreeFunction,
    required this.age,
});

  Map<String, dynamic> toJson() {
    return {
      'pregnancies': pregnancies,
      'glucose': glucose,
      'blood_pressure': bloodPressure,
      'skin_thickness': skinThickness,
      'insulin': insulin,
      'bmi': bmi,
      'diabetes_pedigree_function': diabetesPedigreeFunction,
      'age': age,
    };
  }

}