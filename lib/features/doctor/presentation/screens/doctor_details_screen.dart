import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:health_care_application/features/doctor/data/models/doctor.dart';
import 'package:health_care_application/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  final DateTime _selectedDate = DateTime.now();
  String? _selectedTime;

  Future<void> _onCallButtonTap() async {
    final phoneNumber = '+919545896641';
    final url = 'tel:$phoneNumber';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Utils.showSnackBar('Unable to make a call to $phoneNumber');
    }
  }

  Future<void> _sendAppointmentEmail() async {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    final String formattedDate = Utils.getFormattedDate(_selectedDate);
    final email = Email(
      subject: 'Doctor Appointment',
      body: '''
Hello Dr. ${widget.doctor.name},

You have a new appointment booked by $userEmail.

📅 Date: $formattedDate
🕒 Time: $_selectedTime

Thank you!
''',
      recipients: [widget.doctor.email],
      isHTML: false,
      attachmentPaths: [],
    );
    await FlutterEmailSender.send(email);
  }

  void _onAppointmentButtonTap() async {
    if (_selectedTime == null) {
      Utils.showSnackBar('Please select a time');
      return;
    }

    await _sendAppointmentEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text(widget.doctor.name), centerTitle: true);
  }

  Widget _buildBody() {
    final screenHeight = Utils.getScreenHeight(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.05,
            left: 0,
            right: 0,
            child: _buildDoctorDetails(),
          ),
          Positioned(
            top: screenHeight * 0.010,
            left: 0,
            right: 0,
            child: _buildProfilePic(),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorDetails() {
    final screenHeight = Utils.getScreenHeight(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      width: double.maxFinite,
      height: screenHeight * 0.86,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameComponent(),
          SizedBox(height: screenHeight * 0.01),
          _buildSpecializationComponent(),
          SizedBox(height: screenHeight * 0.01),
          _buildCallButton(),
          SizedBox(height: screenHeight * 0.02),
          _buildRatingsComponent(),
          SizedBox(height: screenHeight * 0.02),
          _buildInfoComponent(),
          SizedBox(height: screenHeight * 0.02),
          Text(
            'Available Time',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: screenHeight * 0.02),
          _buildAvailableTimes(),
          SizedBox(height: screenHeight * 0.02),
          _buildAppointmentBookButtonComponent(),
        ],
      ),
    );
  }

  Widget _buildNameComponent() {
    return Text(
      widget.doctor.name,
      style: Theme.of(
        context,
      ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900),
    );
  }

  Widget _buildSpecializationComponent() {
    return Text(
      widget.doctor.specialization,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
    );
  }

  Widget _buildCallButton() {
    return InkWell(
      onTap: _onCallButtonTap,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
        ),
        child: TextButton(
          onPressed: () async {
            final phoneNumber = '+91${widget.doctor.phoneNumber}';
            final url = 'tel:$phoneNumber';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {
              Utils.showSnackBar('Unable to make a call to $phoneNumber');
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.call, color: Theme.of(context).colorScheme.primary),
              SizedBox(width: 10),
              Text(
                'Call',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingsComponent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.favorite, color: Colors.red),
        SizedBox(width: 5),
        Text('${widget.doctor.ratings}'),
        SizedBox(width: 5),
        Text('Positive Ratings', style: Theme.of(context).textTheme.bodyLarge!),
      ],
    );
  }

  Widget _buildInfoComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Information',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 5),
        ListTile(
          leading: Text(
            'Years of Experience',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Text(
            '${widget.doctor.experience}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        ListTile(
          leading: Text(
            'Patients Checked',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Text(
            '${widget.doctor.patientsChecked}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableTimes() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _buildAvailableTimeCard(widget.doctor.availableTimes[index]);
        },
        itemCount: widget.doctor.availableTimes.length,
      ),
    );
  }

  Widget _buildAvailableTimeCard(String text) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final selectedTextColor = isDarkTheme ? Colors.black : Colors.white;
    final isSelected = _selectedTime == text;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTime = text;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface.withOpacity(0.6),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w900,
            color: isSelected ? selectedTextColor : textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentBookButtonComponent() {
    return InkWell(
      onTap: _onAppointmentButtonTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
        ),
        child: Text(
          'BOOK AN APPOINTMENT',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  Widget _buildProfilePic() {
    return CircleAvatar(
      radius: 45,
      backgroundImage: NetworkImage(widget.doctor.imageUrl),
    );
  }
}
