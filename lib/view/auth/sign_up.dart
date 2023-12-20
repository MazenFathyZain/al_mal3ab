import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kora/controller/auth_services.dart';
import 'package:kora/view/widgets/custom_button.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  SignUp({super.key});

  final AuthServices controller = Get.put(AuthServices());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Image
                Image.asset(
                  'assets/ic_launcher.png', // Replace with your image asset
                  width: width * 75 / 100,
                  height: height * 30 / 100,
                ),
                const SizedBox(height: 20),

                // TextFormFields
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'الاسم الأول',
                    hintText: "أدخل الاسم الاول",
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'برجاءإدخال الاسم الأول';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'اسم العائلة',
                    hintText: "أدخل اسم العائلة",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null) {
                      return 'برجاءإدخال اسم العائلة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'الحساب الإلكتروني',
                    hintText: "أدخل الحساب الخاص بك",
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'برجاءإدخال الحساب الخاص بك';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    hintText: "أدخل كلمة المرور",
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'برجاءإدخال كلمة المرور';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                // Sign Up Button
                Container(
                  padding: const EdgeInsets.only(top: 2.0),
                  width: double.infinity,
                  child: CustomButton(
                    text: "إنشاء حساب",
                    onpressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.signUp(
                          _nameController.text,
                          _lastNameController.text,
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
