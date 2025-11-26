import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_application/features/profile/presentation/providers/profile_provider.dart';
import 'package:health_care_application/features/profile/presentation/screens/profile_screen.dart';
import 'package:health_care_application/main.dart';
import 'package:provider/provider.dart';

import '../../features/auth/presentation/providers/authentication_provider.dart';
import '../../utils/utils.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void onSignOutPressed() async {
      final authProvider = Provider.of<AuthenticationProvider>(
        context,
        listen: false,
      );
      Utils.showCircularProgressIndicator(context);
      await authProvider.signOut();
      navigatorKey.currentState!.pop();
    }

    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    return Drawer(
      child: Column(
        children: [
          FutureBuilder(
            future: profileProvider.fetchUser(
              FirebaseAuth.instance.currentUser!.uid,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final endUser = snapshot.data;
              return DrawerHeader(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      endUser!.name[0],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  title: Text(endUser.name),
                  subtitle: Text(endUser.email),
                  onTap: () {
                    navigatorKey.currentState!.pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(endUser: endUser),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Spacer(),
          InkWell(
            onTap: onSignOutPressed,
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
            ),
          ),
          // Other list items can go here
        ],
      ),
    );
  }
}
