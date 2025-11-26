class Doctor {
  final String name;
  final String email;
  final String specialization;
  final int ratings;
  final String imageUrl;
  final String location;
  final int patientsChecked;
  final String phoneNumber;
  final int experience;
  final List<String> availableTimes;

  const Doctor({
    required this.name,
    required this.email,
    required this.specialization,
    required this.ratings,
    required this.imageUrl,
    required this.location,
    required this.patientsChecked,
    required this.phoneNumber,
    required this.experience,
    required this.availableTimes,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      specialization: json['specialization'] ?? '',
      ratings: json['ratings'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      location: json['location'] ?? '',
      patientsChecked: json['patientsChecked'] ?? 0,
      phoneNumber: json['phoneNumber'] ?? '',
      experience: json['experience'] ?? 0,
      availableTimes: List<String>.from(json['availableTimes'] ?? []),
    );
  }
}
