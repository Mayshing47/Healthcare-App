
import 'package:health_care_application/features/auth/data/models/end_user.dart';

abstract class ProfileRepository {

  Future<void> saveUser(EndUser endUser, String uid);
  Future<EndUser?> fetchUser(String uid);

}