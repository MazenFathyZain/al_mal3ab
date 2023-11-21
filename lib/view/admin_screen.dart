import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kora/controller/login_web_services.dart';
import 'package:kora/model/user.dart';
import 'package:kora/view/auth/detailes_screen.dart';
import 'package:kora/view/stad_detailes_screen.dart';
import '../constants.dart';

class AdminScreen extends StatelessWidget {
  final List ownClubs;

  AdminScreen({super.key, required this.ownClubs});
  LoginWebServices controller = Get.put(LoginWebServices());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
        elevation: 0,
        title: const Text(
          "الملعب",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Dimabanou',
          ),
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            "assets/3.png",
          ),
        ],
      ),
      body: screen(),
    );
  }

  screen() {
    if (ownClubs.length > 1) {
      return allClubs();
    } else if (ownClubs[0]['stadiums'].length > 1) {
      return stadiums();
    } else {
      return availability();
    }
  }

  SingleChildScrollView allClubs() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: ownClubs.length,
              itemBuilder: (context, index) {
                Uint8List bytes =
                    base64Decode(controller.users[index].photos![0]);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // controller.pMethod();
                          Get.to(
                            Detailes(
                              stads: controller.users[index].stadiums![0],
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.memory(bytes, fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      // controller.users[0].name!,
                                      "ملعب ${ownClubs[index]['name']!}",
                                      style: GoogleFonts.righteous().copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  stadiums() {
    Uint8List bytes = base64Decode(ownClubs[0]['stadiums'][0]['photos'][0]);
    return ListView.builder(
        itemCount: ownClubs[0]['stadiums'].length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Get.to(
              //   StadDetailes(
              //     stads: stads[index],
              //   ),
              // );
            },
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: MemoryImage(bytes),
                ),
                title: Text(ownClubs[index]['stadiums'][index]['name']),
                trailing:
                    Text(ownClubs[index]['stadiums'][index]['size'].toString()),
              ),
            ),
          );
        });
  }

  availability() {
    return const Center(
      child: Text("availability"),
    );
  }

  final Rx<DateTime> selectedDate = DateTime.now().obs;

  void _showDatePicker(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 13)),
      locale: const Locale('ar', 'SA'), // Set the Arabic locale
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      print('Selected date: $pickedDate');
      // getOneDate();
    }
  }

  // Rx<Availability> getOneDate() {
  //   return stads.availability!
  //       .firstWhere((element) =>
  //           element.date!.substring(0, 10) ==
  //           selectedDate.value.toString().substring(0, 10))
  //       .obs;
  // }
}
