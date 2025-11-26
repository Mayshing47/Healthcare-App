import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_care_application/constants/string_constants.dart';
import 'package:health_care_application/features/auth/data/models/end_user.dart';
import 'package:health_care_application/features/auth/presentation/providers/authentication_provider.dart';
import 'package:health_care_application/features/auth/presentation/widgets/custom_button.dart';
import 'package:health_care_application/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:health_care_application/features/auth/presentation/widgets/heading_component.dart';
import 'package:health_care_application/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../../../constants/image_constants.dart';
import '../../../../main.dart';
import '../widgets/description_component.dart';
import '../widgets/social_sign_in_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.onSignInTap});

  final void Function() onSignInTap;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _onSignUpTapped() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Utils.showSnackBar('Enter all fields');
      return;
    }

    if (password.length < 6) {
      Utils.showSnackBar('Password must be at least 6 characters');
      return;
    }

    if (password != confirmPassword) {
      Utils.showSnackBar('Passwords do not match');
      return;
    }

    final endUser = EndUser(
      id: '',
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );

    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    await authProvider.signUpWithEmail(endUser: endUser, password: password);
  }

  void _onSignInWithGoogleTap() {}

  void _onSignInWithAppleTap() {}

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }



  Widget _buildBody() {
    final screenHeight = Utils.getScreenHeight(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeadingComponent(headingText: signUpHeadingText),
              SizedBox(height: screenHeight * 0.02),
              DescriptionComponent(descriptionText: signUpDescriptionText),
              SizedBox(height: screenHeight * 0.05),
              _buildNameField(),
              SizedBox(height: screenHeight * 0.02),
              _buildEmailField(),
              SizedBox(height: screenHeight * 0.02),
              _buildPasswordField(),
              SizedBox(height: screenHeight * 0.02),
              _buildConfirmPasswordField(),
              SizedBox(height: screenHeight * 0.05),
              _buildSignUpButton(),
              SizedBox(height: screenHeight * 0.02),
              _buildDividerWithMessage(),
              SizedBox(height: screenHeight * 0.02),
              // _buildSocialButtonsRow(),
              SizedBox(height: screenHeight * 0.02),
              _buildBottomMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return CustomTextField(
      labelText: 'Name',
      controller: _nameController,
      isPasswordField: false,
      obscureText: false,
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      labelText: emailLabelText,
      controller: _emailController,
      isPasswordField: false,
      obscureText: false,
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      labelText: passwordLabelText,
      controller: _passwordController,
      isPasswordField: true,
      obscureText: _obscurePassword,
      togglePasswordState: _togglePasswordVisibility,
    );
  }

  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      labelText: confirmPasswordLabelText,
      controller: _confirmPasswordController,
      isPasswordField: true,
      obscureText: _obscureConfirmPassword,
      togglePasswordState: _toggleConfirmPasswordVisibility,
    );
  }

  Widget _buildSignUpButton() {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Consumer<AuthenticationProvider>(
      builder: (context, provider, _) {
        return CustomButton(
          onTap: _onSignUpTapped,
          child:
          provider.isLoading
              ? CircularProgressIndicator(color: Colors.black,)
              : Text(
            signInHeadingText,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: isDarkTheme ? Colors.black : Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!,
        ),
        TextButton(
          onPressed: widget.onSignInTap,
          child: Text(
            'Sign In',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDividerWithMessage() {
    return Row(
      children: [
        Expanded(child: Divider()),
        Text(
          '  OR  ',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!,
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSocialButtonsRow() {
    return Platform.isAndroid
        ? SocialSignInButton(
          logoUrl: googleLogo,
          label: googleButtonLabel,
          isGoogleSignInButton: true,
          onTap: _onSignInWithGoogleTap,
        )
        : Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SocialSignInButton(
              logoUrl: googleLogo,
              label: googleButtonLabel,
              isGoogleSignInButton: true,
              onTap: _onSignInWithGoogleTap,
            ),
            SocialSignInButton(
              logoUrl: appleLogo,
              label: appleButtonLabel,
              isGoogleSignInButton: false,
              onTap: _onSignInWithAppleTap,
            ),
          ],
        );
  }
}
