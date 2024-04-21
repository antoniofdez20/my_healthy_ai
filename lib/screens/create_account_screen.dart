import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/controllers/controllers.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Healthy AI'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 35),
                      child: Text('Create Account',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                    ),
                    TextFormField(
                      onChanged: (value) => {},
                      /* validator: (value) =>
                                  {}, */
                      style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? MyColors.midnightGreen
                            : MyColors.prussianBlue,
                      ),
                      cursorColor: themeController.isDarkMode.value
                          ? MyColors.midnightGreen
                          : MyColors.prussianBlue,
                      decoration: CustomInputDecoration.buildInputDecoration(
                          labelText: 'Username',
                          themeController: themeController),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      onChanged: (value) => {},
                      /* validator: (value) =>
                                  {}, */
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
                    TextFormField(
                      onChanged: (value) => {},
                      /* validator: (value) =>
                                  {}, */
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
                    TextFormField(
                      onChanged: (value) => {},
                      /* validator: (value) =>
                                  {}, */
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
                        labelText: 'Confirm Password',
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
                      onPressed: () => {},
                      child: const Text('Create Account'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
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
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
