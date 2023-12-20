import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kora/constants.dart';
import 'package:get/get.dart';
import 'package:kora/controller/admin_clubs.dart';
import 'package:kora/view/admin_screens/admin_stad_detailes_screen.dart';
import 'package:kora/view/admin_screens/admin_stads_screen.dart';
import 'package:kora/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AdminScreen extends StatelessWidget {
  AdminScreen({super.key});

  // final AdminClubs controller = Get.find<AdminClubs>();
  final AdminClubs controller = Get.put(AdminClubs());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
        elevation: 0,
        title: const Text(
          "أدمن الملعب",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Dimabanou',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              Get.offAll(() => HomeScreen());
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: Obx(
        () {
          if (controller.clubs.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.clubs.length,
              itemBuilder: (context, index) {
                final club = controller.clubs[index];
                // Uint8List bytes = base64Decode(club.stadiums![0].images![0]
                //     .substring(23)); //club.photos![0]);
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 16.0,
                    left: 16.0,
                    bottom: 4.0,
                    top: 4.0,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (club.stadiums!.length > 1) {
                            Get.to(
                              AdminStadsScreen(
                                stads: club.stadiums!,
                                stadIndex: index,
                                clubId: club.id!,
                              ),
                            );
                          } else {
                            Get.to(AdminStadDetailes(
                              stads: club.stadiums![0],
                              stadIndex: index,
                              clubId: club.id!,
                            ));
                          }
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
                                  child: Image.asset('assets/image.jpg',
                                      fit: BoxFit.cover),
                                  // child: Image.memory(bytes, fit: BoxFit.cover),
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
                                      club.name!,
                                      style: GoogleFonts.righteous().copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      club.address.toString(),
                                      style: GoogleFonts.righteous().copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "${club.stadiums![0].cost.toString()} م.ج",
                                      style: GoogleFonts.righteous().copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Expanded(
                              //   child: Align(
                              //     alignment: Alignment.bottomRight,
                              //     child: IconButton(
                              //         onPressed: () {},
                              //         icon: const Icon(
                              //             Icons.favorite_border)),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
