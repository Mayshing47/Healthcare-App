import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_application/features/profile/presentation/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../auth/data/models/end_user.dart';
import '../widgets/profile_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.endUser});

  final EndUser endUser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ProfileForm(endUser: widget.endUser),
        ),
      ),
    );
  }
}
