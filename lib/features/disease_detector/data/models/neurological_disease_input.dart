

class NeurologicalDiseaseInput {
  final double meanAmplitude;
  final double peakToPeak;
  final double psd;
  final double entropy;
  final double deltaPower;
  final double thetaPower;
  final double alphaPower;
  final double betaPower;
  final double gammaPower;

  NeurologicalDiseaseInput({
    required this.meanAmplitude,
    required this.peakToPeak,
    required this.psd,
    required this.entropy,
    required this.deltaPower,
    required this.thetaPower,
    required this.alphaPower,
    required this.betaPower,
    required this.gammaPower,
});


  Map<String, dynamic> toJson() {
    return {
      'Mean_Amplitude': meanAmplitude,
      'Peak_to_Peak': peakToPeak,
      'PSD': psd,
      'Entropy': entropy,
      'Delta_Power': deltaPower,
      'Theta_Power': thetaPower,
      'Alpha_Power': alphaPower,
      'Beta_Power': betaPower,
      'Gamma_Power': gammaPower,
    };
  }
}