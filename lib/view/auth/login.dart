import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kora/constants.dart';
import 'package:kora/controller/login_web_services.dart';
import 'package:kora/view/widgets/custom_button.dart';
import 'package:kora/view/widgets/custom_text_form_field.dart';


class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginWebServices controller = Get.put(LoginWebServices());

  Widget logo(width, height) {
    return Image.asset(
      "assets/ic_launcher.png",
      width: width * 75 / 100,
      height: height * 30 / 100,
    );
  }

  Widget loginForm(double width, double height) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: _emailController,
            text: "البريد الالكتروني",
            hint: "أدخل البريد الالكتروني",
          ),
          SizedBox(
            height: height * 4 / 100,
          ),
          CustomTextFormField(
            controller: _passwordController,
            text: "كلمة السر",
            hint: "ادخل كلمة السر",
            obscureText: true,
          ),
          SizedBox(
            height: height * 4 / 100,
          ),
          Container(
            padding: const EdgeInsets.only(top: 2.0),
            width: width,
            child: CustomButton(
              text: "تسجيل الدخول",
              onpressed: () {
                controller.isLoading.value
                    ? null
                    : controller.login(
                        _passwordController.text, _emailController.text);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => Stack(
            children: [
              if (controller.isLoading.value)
                Padding(
                  padding: EdgeInsets.only(top: height * 50 / 100),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: primaryColor,
                  )),
                ),
              Column(
                children: [
                  SizedBox(height: height * 10 / 100),
                  logo(width, height),
                  loginForm(width, height),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
