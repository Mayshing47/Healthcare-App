import 'package:flutter/material.dart';
import 'package:health_care_application/features/auth/data/models/end_user.dart';
import 'package:health_care_application/utils/utils.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key, required this.endUser});

  final EndUser endUser;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Circle photo
        CircleAvatar(
          radius: 50,
          child: Text(endUser.name[0], style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w900
          ),),
        ),
        const SizedBox(height: 16),

        Text(
          endUser.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          endUser.email,
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),

        // Created At
        Text(
          Utils.getFormattedDate(endUser.createdAt),
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
