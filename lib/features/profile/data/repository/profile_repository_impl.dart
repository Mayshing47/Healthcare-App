

import 'package:health_care_application/features/auth/data/models/end_user.dart';
import 'package:health_care_application/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:health_care_application/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<void> saveUser(EndUser endUser, String uid) async {
    await profileRemoteDataSource.saveUser(endUser: endUser, uid: uid);
  }

  @override
  Future<EndUser?> fetchUser(String id) async {
    return await profileRemoteDataSource.fetchUser(uid: id);
  }



}