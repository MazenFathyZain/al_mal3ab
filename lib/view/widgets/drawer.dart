import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kora/constants.dart';
import 'package:kora/controller/auth_services.dart';
import 'package:kora/view/home_screen.dart';
import 'package:kora/view/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  AuthServices controller = Get.put(AuthServices());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<dynamic>(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String? token = snapshot.data;
            return Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Image.asset("assets/ic_launcher.png"),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                        color: primaryColor,
                        size: 30,
                      ),
                      title: const Text(
                        "الصفحة الرئيسية",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        Route route =
                            MaterialPageRoute(builder: (c) => HomeScreen());
                        Navigator.pushReplacement(context, route);
                      },
                    ),
                    // ListTile(
                    //   leading: const Icon(Icons.notifications_active_rounded,
                    //       color: primaryColor, size: 30),
                    //   title: const Text(
                    //     "الملاعب المتابعه",
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 15,
                    //     ),
                    //   ),
                    //   onTap: () {},
                    // ),
                    token != null
                        ? Container()
                        : ListTile(
                            leading: const Icon(
                              Icons.login,
                              color: primaryColor,
                              size: 30,
                            ),
                            title: const Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            onTap: () {
                              Get.to(Login());
                            },
                          ),
                    token == null
                        ? Container()
                        : ListTile(
                            leading: const Icon(
                              Icons.login,
                              color: primaryColor,
                              size: 30,
                            ),
                            title: const Text(
                              "تسجيل الخروج",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('token');
                              await prefs.remove('email');
                              controller.mail.value = '';
                              Get.offAll(HomeScreen());
                            },
                          ),
                    // ListTile(
                    //   leading: const Icon(Icons.contact_support_outlined,
                    //       color: primaryColor, size: 30),
                    //   title: const Text(
                    //     "تواصل معنا",
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 15,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     // final FirebaseAuth _auth = FirebaseAuth.instance;
                    //     // _auth.signOut();
                    //     // Get.offAll(Login());
                    //   },
                    // ),
                    // ListTile(
                    //   leading: const Icon(Icons.settings,
                    //       color: primaryColor, size: 30),
                    //   title: const Text(
                    //     "الإعدادات",
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 15,
                    //     ),
                    //   ),
                    //   onTap: () async {},
                    // ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
