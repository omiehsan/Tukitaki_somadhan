import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/texts.dart';
import '../../controllers/signin_controller.dart';
import '../forget_pass/options/forget_pass_bottom_sheet_modal.dart';

class LoginFormSection extends StatelessWidget {
  LoginFormSection({
    Key? key,
  }) : super(key: key);

  RxBool isVisible = true.obs;
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: loginController.email,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Email is Required!';
                }
                // Email Field Validation
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return "Please Enter a Valid Email";
                }
                // Return Null If Valid
                return null;
              },
              decoration: const InputDecoration(
                label: Text(TTS_Email),
                hintText: TTS_Email,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            Obx(
              () => TextFormField(
                obscureText: isVisible.value,
                controller: loginController.password,
                validator: (value) {
                  // Is Empty Validation
                  if (value == null || value.isEmpty) {
                    return 'Password is Required!';
                  }
                  // Return Null If Valid
                  return null;
                },
                decoration: InputDecoration(
                  labelText: TTS_Password,
                  hintText: TTS_Password,
                  prefixIcon: Icon(Icons.fingerprint),
                  suffixIcon: IconButton(
                    onPressed: () => passVisibility(),
                    icon: isVisible.value ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                  ),
                ),
              ),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  ForgetPassBottomSheetModal.buildShowModalBottomSheet(context);
                },
                child: Text(TTS_ForgetPassword, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: TTS_AccentColor)),
              ),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    LoginController.instance.loginUser(loginController.email.text.trim(), loginController.password.text.trim());
                  }
                },
                child: Text(TTS_Login.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  passVisibility() {
    isVisible.value = !isVisible.value;
  }
}
