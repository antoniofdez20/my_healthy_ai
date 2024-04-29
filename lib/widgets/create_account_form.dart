import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class CreateAccountForm extends StatelessWidget {
  CreateAccountForm({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    FormValidator formValidator = FormValidator();
    AuthController authController = Get.find<AuthController>();
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 35),
            child: Text('Create Account',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ),
          TextFormField(
            controller: authController.usernameController,
            validator: formValidator.isValidName,
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? MyColors.midnightGreen
                  : MyColors.prussianBlue,
            ),
            cursorColor: themeController.isDarkMode.value
                ? MyColors.midnightGreen
                : MyColors.prussianBlue,
            decoration: CustomInputDecoration.buildInputDecoration(
                labelText: 'Username', themeController: themeController),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: authController.emailController,
            validator: formValidator.isValidEmail,
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? MyColors.midnightGreen
                  : MyColors.prussianBlue,
            ),
            cursorColor: themeController.isDarkMode.value
                ? MyColors.midnightGreen
                : MyColors.prussianBlue,
            decoration: CustomInputDecoration.buildInputDecoration(
                labelText: 'Email', themeController: themeController),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          Obx(
            () => TextFormField(
              controller: authController.passwordController,
              validator: formValidator.isValidPass,
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? MyColors.midnightGreen
                    : MyColors.prussianBlue,
              ),
              cursorColor: themeController.isDarkMode.value
                  ? MyColors.midnightGreen
                  : MyColors.prussianBlue,
              obscureText: authController.isPassObscured.value,
              decoration: CustomInputDecoration.buildInputDecoration(
                labelText: 'Password',
                themeController: themeController,
                suffixIcon: IconButton(
                  icon: Icon(
                    authController.isPassObscured.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility,
                    color: themeController.isDarkMode.value
                        ? MyColors.midnightGreen
                        : MyColors.prussianBlue,
                  ),
                  onPressed: () => authController.togglePasswordVisibility(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => TextFormField(
              controller: authController.confirmPasswordController,
              validator: (value) => formValidator.isValidPassConfirmed(
                authController.passwordController.text,
                authController.confirmPasswordController.text,
              ),
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? MyColors.midnightGreen
                    : MyColors.prussianBlue,
              ),
              cursorColor: themeController.isDarkMode.value
                  ? MyColors.midnightGreen
                  : MyColors.prussianBlue,
              obscureText: authController.isConfirmPassObscured.value,
              decoration: CustomInputDecoration.buildInputDecoration(
                labelText: 'Confirm Password',
                themeController: themeController,
                suffixIcon: IconButton(
                  icon: Icon(
                    authController.isConfirmPassObscured.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility,
                    color: themeController.isDarkMode.value
                        ? MyColors.midnightGreen
                        : MyColors.prussianBlue,
                  ),
                  onPressed: () =>
                      authController.toggleConfirmPasswordVisibility(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await authController.registerWithEmailAndPassword();
              }
            },
            child: const Text('Create Account'),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Login here',
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? MyColors.midnightGreen
                          : MyColors.carolinaBlue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.offNamed('/loginScreen');
                        authController.resetCredentials();
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
