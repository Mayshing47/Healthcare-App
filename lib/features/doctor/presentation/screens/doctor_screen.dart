import 'package:flutter/material.dart';
import 'package:health_care_application/features/doctor/data/models/doctor.dart';
import 'package:health_care_application/features/doctor/presentation/providers/doctor_provider.dart';
import 'package:health_care_application/features/doctor/presentation/widgets/doctor_tile.dart';
import 'package:provider/provider.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Consumer<DoctorProvider>(
        builder: (context, doctorProvider, child) {
          return FutureBuilder(
            future: doctorProvider.fetchDoctors(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.hasData) {
                final doctors = snapshot.data as List<Doctor>;
                return _buildDoctorsList(doctors);
              } else {
                return const Center(child: Text('No Doctors Found'));
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildDoctorsList(List<Doctor> doctors) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return DoctorTile(doctor: doctors[index],);
      },
      itemCount: doctors.length,
    );
  }
}
