import 'package:flutter/material.dart';
import 'package:health_care_application/features/doctor/data/models/doctor.dart';
import 'package:health_care_application/main.dart';

import '../screens/doctor_details_screen.dart';

class DoctorTile extends StatelessWidget {
  const DoctorTile({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: _buildProfileImage(),
        title: _buildDoctorName(context),
        subtitle: Text(doctor.specialization),
        trailing: _buildTrailingIcon(context),
      ),
    );
  }

  Widget _buildProfileImage() {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        doctor.imageUrl,
      ),
    );
  }

  Widget _buildDoctorName(BuildContext context) {
    return Text(
      doctor.name,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTrailingIcon(BuildContext context) {
    return IconButton(onPressed: () {
      navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => DoctorDetailsScreen(doctor: doctor)));
    }, icon: Icon(Icons.arrow_forward_ios));
  }
}
