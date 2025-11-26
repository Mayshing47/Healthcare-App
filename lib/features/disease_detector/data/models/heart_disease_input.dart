class HeartDiseaseInput {
  final String bmiCategory;
  final String smoking;
  final String alcoholDrinking;
  final String stroke;
  final int physicalHealth;
  final int mentalHealth;
  final String diffWalking;
  final String sex;
  final String ageCategory;
  final String race;
  final String diabetic;
  final String physicalActivity;
  final String genHealth;
  final int sleepTime;
  final String asthma;
  final String kidneyDisease;
  final String skinCancer;

  HeartDiseaseInput({
    required this.bmiCategory,
    required this.smoking,
    required this.alcoholDrinking,
    required this.stroke,
    required this.physicalHealth,
    required this.mentalHealth,
    required this.diffWalking,
    required this.sex,
    required this.ageCategory,
    required this.race,
    required this.diabetic,
    required this.physicalActivity,
    required this.genHealth,
    required this.sleepTime,
    required this.asthma,
    required this.kidneyDisease,
    required this.skinCancer,
  });

  Map<String, dynamic> toJson() {
    return {
      "BMICategory": bmiCategory,
      "Smoking": smoking,
      "AlcoholDrinking": alcoholDrinking,
      "Stroke": stroke,
      "PhysicalHealth": physicalHealth,
      "MentalHealth": mentalHealth,
      "DiffWalking": diffWalking,
      "Sex": sex,
      "AgeCategory": ageCategory,
      "Race": race,
      "Diabetic": diabetic,
      "PhysicalActivity": physicalActivity,
      "GenHealth": genHealth,
      "SleepTime": sleepTime,
      "Asthma": asthma,
      "KidneyDisease": kidneyDisease,
      "SkinCancer": skinCancer,
    };
  }
}
