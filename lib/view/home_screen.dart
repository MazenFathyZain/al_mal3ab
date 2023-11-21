import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kora/constants.dart';
import 'package:get/get.dart';
import 'package:kora/view/stad_detailes_screen.dart';
import 'package:kora/view/stads_screen.dart';

import '../controller/club_web_services.dart';
import 'widgets/drawer.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  ClubWebServices controller = Get.put(ClubWebServices());

  Widget search() {
    return Row(
      children: [
        Container(
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            onPressed: () {
              // Handle filter button press
            },
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'ابحث عن الملعب',
                hintStyle:
                    TextStyle(color: Colors.grey[400]), // Change the color here
                suffixIcon: const Icon(
                  Icons.search,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
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
      body: Obx(() {
        if (controller.clubs.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  search(),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.clubs.length,
                    itemBuilder: (context, index) {
                      final club = controller.clubs[index];
                      Uint8List bytes =
                          base64Decode(club.photos![0]); //club.photos![0]);
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (club.stadiums!.length > 1) {
                                  Get.to(
                                    StadsScreen(
                                      stads: club.stadiums!,
                                    ),
                                  );
                                } else {
                                  Get.to(
                                    StadDetailes(
                                      stads: club.stadiums![0],
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
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
                                        child: Image.memory(bytes,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "ملعب ${club.name!}",
                                            style: GoogleFonts.righteous()
                                                .copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            club.address!,
                                            style: GoogleFonts.righteous()
                                                .copyWith(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "${club.cost!} م.ج",
                                            style: GoogleFonts.righteous()
                                                .copyWith(
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
      }),
    );
  }
}
