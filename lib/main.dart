import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kora/constants.dart';
import 'package:kora/controller/admin_clubs.dart';
import 'package:kora/view/admin_screens/admin_screen.dart';
import 'package:kora/view/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color(0xFF33BF4A),
  // background: const Color.fromARGB(255, 236, 243, 237),
);

final theme = ThemeData().copyWith(
    scaffoldBackgroundColor: colorScheme.background,
    colorScheme: colorScheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    ),
    iconTheme: const IconThemeData(
      color: primaryColor,
    ));
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String? role = prefs.getString('role');
  runApp(MyApp(token, role));
}

class MyApp extends StatelessWidget {
  final String? token;
  final String? role;
  const MyApp(this.token, this.role, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'), // Arabic
      ],
      debugShowCheckedModeBanner: false,
      title: 'Great Places',
      theme: theme,
      navigatorKey: Get.key,
      initialBinding: BindingsBuilder(() {
        // Get.put(DataController());
      }),
      initialRoute:
          token == null || token!.isEmpty || role == 'USER' ? '/' : 'admin',
      routes: {
        '/': (context) => HomeScreen(),
        'admin': (context) => AdminScreen(),
      },
    );
  }
}
