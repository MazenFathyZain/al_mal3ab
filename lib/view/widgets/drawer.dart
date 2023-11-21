import 'package:flutter/material.dart';
import 'package:kora/constants.dart';
import 'package:kora/view/home_screen.dart';
import 'package:kora/view/auth/login.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
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
                  Route route = MaterialPageRoute(builder: (c) => HomeScreen());
                  Navigator.pushReplacement(context, route);
                },
              ),
              ListTile(
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
                  Route route = MaterialPageRoute(builder: (c) => Login());
                  Navigator.pushReplacement(context, route);
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite_border_outlined,
                    color: primaryColor, size: 30),
                title: const Text(
                  "الملاعب المفضلة",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  // Route route =
                  //     MaterialPageRoute(builder: (c) => ProfileView());
                  // Navigator.push(context, route);
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications_on_outlined,
                    color: primaryColor, size: 30),
                title: const Text(
                  "الإشعارات",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.contact_support_outlined,
                    color: primaryColor, size: 30),
                title: const Text(
                  "تواصل معنا",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  // final FirebaseAuth _auth = FirebaseAuth.instance;
                  // _auth.signOut();
                  // Get.offAll(Login());
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.settings, color: primaryColor, size: 30),
                title: const Text(
                  "الإعدادات",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  // final FirebaseAuth _auth = FirebaseAuth.instance;
                  // _auth.signOut();
                  // Get.offAll(Login());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
