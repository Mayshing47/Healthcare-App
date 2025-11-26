import 'package:flutter/material.dart';
import 'package:health_care_application/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:health_care_application/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../providers/authentication_provider.dart';
import '../widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _forgotPasswordController;


  @override
  void initState() {
    _forgotPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _forgotPasswordController.dispose();
    super.dispose();
  }

  void _onForgotPasswordTap() async {
    final email = _forgotPasswordController.text.trim();

    if(email.isEmpty) {
      Utils.showSnackBar('Please enter your email');
      return;
    }

    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    await authProvider.forgotPassword(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text('Forgot Password'));
  }

  Widget _buildBody() {
    final screenHeight = Utils.getScreenHeight(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildForgotPasswordField(),
              SizedBox(height: screenHeight * 0.02),
              _buildForgotPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordField() {
    return CustomTextField(
      labelText: 'Email',
      controller: _forgotPasswordController,
      isPasswordField: false,
      obscureText: false,
    );
  }

  Widget _buildForgotPasswordButton() {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Consumer<AuthenticationProvider>(
      builder: (context, provider, _) {
        return CustomButton(
          onTap: _onForgotPasswordTap,
          child:
          provider.isLoading
              ? CircularProgressIndicator(color: Colors.black,)
              : Text(
            "forgot password",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: isDarkTheme ? Colors.black : Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        );
      },
    );
  }
}
