import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:health_care_application/common/widgets/my_drawer.dart';
import 'package:health_care_application/features/chatbot/presentation/screens/chat_screen.dart';
import 'package:health_care_application/features/disease_detector/presentation/screens/disease_detector.dart';
import 'constants/icon_constants.dart';
import 'features/doctor/presentation/screens/doctor_screen.dart';
import 'features/ocr/presentation/screens/ocr_screen.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;
  final _pages = [
    DoctorScreen(),
    ChatScreen(),
    DiseaseDetectorScreen(),
    OcrScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }


  // void _onSignOutTap() async {
  //   final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
  //   Utils.showCircularProgressIndicator(context);
  //   await authProvider.signOut();
  //   navigatorKey.currentState!.pop();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MyDrawer(
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar();
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      clipBehavior: Clip.hardEdge,
      child: GNav(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
        tabs: [
          GButton(icon: _selectedIndex == 0 ? doctorIcon : doctorOutlinedIcon),
          GButton(
            icon: _selectedIndex == 1 ? dietPlannerIcon : dietPlannerOutlinedIcon,
          ),
          GButton(
            icon:
                _selectedIndex == 2
                    ? diseaseDetectorIcon
                    : diseaseDetectorOutlinedIcon,
          ),
          GButton(icon: _selectedIndex == 3 ? ocrIcon : ocrOutlinedIcon),

        ],
      ),
    );
  }

}
