import 'package:flutter/material.dart';
import 'package:health_care_application/constants/string_constants.dart';
import 'package:health_care_application/features/auth/presentation/widgets/custom_button.dart';
import 'package:health_care_application/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:health_care_application/features/auth/presentation/widgets/heading_component.dart';
import 'package:health_care_application/main.dart';
import 'package:health_care_application/utils/utils.dart';
import 'package:provider/provider.dart';
import '../providers/authentication_provider.dart';
import '../widgets/description_component.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.onSignUpTap});

  final void Function() onSignUpTap;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _onForgotPasswordTap() {
    navigatorKey.currentState!.pushNamed('/forgotPassword');
  }

  void _onSignInTapped() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Utils.showSnackBar('Please fill all the fields');
    }

    final authProvider = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );
    await authProvider.signInWithEmail(email: email, password: password);
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              HeadingComponent(headingText: signInHeadingText),
              SizedBox(height: screenHeight * 0.02),
              DescriptionComponent(descriptionText: singInDescriptionText),
              SizedBox(height: screenHeight * 0.05),
              _buildEmailField(),
              SizedBox(height: screenHeight * 0.02),
              _buildPasswordField(),
              SizedBox(height: screenHeight * 0.02),
              _buildForgotPasswordButton(),
              SizedBox(height: screenHeight * 0.02),
              _buildSignInButton(),
              SizedBox(height: screenHeight * 0.02),
              _buildBottomMessage(),
            ],
          ),
        ),
      ),
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

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: _onForgotPasswordTap,
        child: Text('Forgot Password'),
      ),
    );
  }

  Widget _buildSignInButton() {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Consumer<AuthenticationProvider>(
      builder: (context, provider, _) {
        return CustomButton(
          onTap: _onSignInTapped,
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
          'Don\'t have an account?',
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
        TextButton(
          onPressed: widget.onSignUpTap,
          child: Text(
            'Create Account',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}
