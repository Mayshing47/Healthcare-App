import 'package:flutter/material.dart';
import 'package:health_care_application/features/auth/data/models/end_user.dart';
import 'package:health_care_application/features/profile/domain/repository/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {

  final ProfileRepository profileRepository;

  ProfileProvider({required this.profileRepository});

  EndUser? _endUser;

  EndUser? get endUser => _endUser;

  Future<void> saveUser(EndUser endUser, String uid) async {
    await profileRepository.saveUser(endUser, uid);
    notifyListeners();
  }

  Future<EndUser?> fetchUser(String id) async {
    final user = await profileRepository.fetchUser(id);
    notifyListeners();
    return user;
  }

}