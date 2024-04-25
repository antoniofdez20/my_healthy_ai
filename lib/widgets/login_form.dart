import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
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
            child: Text('Welcome',
                style: TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold)),
          ),
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
                labelText: 'Email',
                themeController: themeController),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
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
            //obscureText: !controller.isPasswordVisible.value,
            decoration: CustomInputDecoration.buildInputDecoration(
              labelText: 'Password',
              themeController: themeController,
              /* suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                    color: themeController.isDarkMode.value
                        ? MyColors.amber
                        : MyColors.greenVogue,
                  ),
                  onPressed: () =>
                      controller.togglePasswordVisibility(),
                ), */
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => {
              if (_formKey.currentState!.validate()) {
                authController.loginWithEmailAndPassword(),
                Get.snackbar("Congrats", "You are logged in!", snackPosition: SnackPosition.BOTTOM),
                Get.offAllNamed('/homeScreen'),
              }
            },
            child: const Text('Login'),
          ),
          Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Create an account here',
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? MyColors.midnightGreen
                          : MyColors.carolinaBlue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.offNamed('/createAccountScreen');
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