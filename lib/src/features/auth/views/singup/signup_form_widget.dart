import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/texts.dart';
import '../../controllers/signup_controller.dart';
import '../../models/users_model.dart';

class SignUpFormSection extends StatelessWidget {
  const SignUpFormSection({
    Key? key,
  }) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(SignUpController());

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: registerController.fullName,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Full Name Is Required!';
                }
                // Return Null If Valid
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  label: Text(TTS_Full_Name),
                  hintText: TTS_Full_Name),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            TextFormField(
              controller: registerController.email,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Email Is Required!';
                }
                // Email Field Validation
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return "Please Enter a Valid Email";
                }
                // Return Null If Valid
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email),
                  label: Text(TTS_Email),
                  hintText: TTS_Email),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            TextFormField(
              controller: registerController.phoneNum,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Phone Number Is Required!';
                }
                if (value.length <= 10) {
                  return 'Phone Number Must Be of 11 Digit';
                }
                // Return Null If Valid
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.numbers),
                  label: Text(TTS_Phone),
                  hintText: TTS_Phone),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            TextFormField(
              controller: registerController.password,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Password Is Required!';
                }
                // Return Null If Valid
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  label: Text(TTS_Password),
                  hintText: TTS_Password),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final userData = UserModel(
                      id: registerController.email.text.trim(),
                      fullName: registerController.fullName.text.trim(),
                      phone: registerController.phoneNum.text.trim(),
                      email: registerController.email.text.trim(),
                      password: registerController.password.text.trim(),
                    );
                    SignUpController.instance.createUser(userData);
                  }
                },
                child: Text(TTS_Register.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
