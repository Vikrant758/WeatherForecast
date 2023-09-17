import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_application/controllers/sign_up_controller.dart';
import 'package:flutter_weather_application/views/sign_in.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Forecast"),
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Sign Up Form',
                style: TextStyle(fontSize: 20),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: Obx(() => TextField(
                  controller: _emailController,
                  onChanged: (value) {
                    controller.emailValidator(value);
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter your email for registration',
                    errorText: controller.emailErrorText.value.isNotEmpty
                        ? controller.emailErrorText.value
                        : null,
                  ),
                )),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Obx(() => TextField(
                  obscureText: true,
                  controller: _passwordController,
                  onChanged: (value) {
                    controller.passwordValidator(value);
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Create a password',
                    errorText: controller.passWordErrorText.value.isNotEmpty
                        ? controller.passWordErrorText.value
                        : null,
                  ),
                )),
          ),
          const SizedBox(height: 30),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Register'),
                onPressed: () {
                  controller.createUserAccountInFirebase(
                      email: _emailController.text,
                      password: _passwordController.text);
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Already have an account?'),
              TextButton(
                child: const Text(
                  'Login from here',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Get.to(() => const SignIn());
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
