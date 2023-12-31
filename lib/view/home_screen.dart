import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kora/constants.dart';
import 'package:get/get.dart';
import 'package:kora/controller/auth_services.dart';
import 'package:kora/controller/following.dart';
import 'package:kora/controller/getNearClubs.dart';
import 'package:kora/controller/get_club_by_id.dart';
import 'package:kora/view/auth/login.dart';
import 'package:kora/view/search_screen.dart';
import 'package:kora/view/stad_detailes_screen.dart';
import 'package:kora/view/stads_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/drawer.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // final LocationController locationController = Get.put(LocationController());
  GetNearClubs controller = Get.put(GetNearClubs());
  Follow followController = Get.put(Follow());
  AuthServices authController = Get.put(AuthServices());
  GetClubById getClubById = Get.put(GetClubById());

  RxList getFollowedEmails() {
    var emails = getClubById.followers
        .map((element) => element['user']['email'])
        .toList()
        .obs;
    return emails;
  }

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
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              var token = await prefs.getString('token');
              // print(authController.mail.value);
              print(token);
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
              showCursor: false,
              keyboardType: TextInputType.none,
              onTap: () {
                Get.to(SearchScreen());
              },
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

  Future<void> _showAlertDialog(BuildContext context, clubName) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('متابعة الملعب'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'لمتابعة ${clubName} والحصول على اشعارات يجب عليك تسجيل الدخول',
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Get.off(Login());
              },
              child: const Text('تسجيل الدخول'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
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
                      getClubs() {
                        return club.followers!
                            .map((e) => e.user!.email)
                            .toList()
                            .obs;
                      }

                      var image = club.stadiums![0].images![0];
                      Uint8List bytes = base64Decode(image != ''
                          ? club.stadiums![0].images![0].substring(23)
                          : '');
                      return SingleChildScrollView(
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: GestureDetector(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: image == ''
                                              ? Image.asset('assets/image.jpg',
                                                  fit: BoxFit.cover)
                                              : Image.memory(bytes,
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
                                              "${club.name!}",
                                              style: GoogleFonts.righteous()
                                                  .copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              club.address.toString(),
                                              style: GoogleFonts.righteous()
                                                  .copyWith(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "${club.stadiums![0].cost.toString()} م.ج",
                                              style: GoogleFonts.righteous()
                                                  .copyWith(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => IconButton(
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    String? token = prefs.getString('token');
                                    await getClubById.getClubById(club.id!);

                                    var emails = getClubById.followers
                                        .map((element) =>
                                            element['user']['email'])
                                        .toList()
                                        .obs;
                                    if (token != null) {
                                      if (emails.contains(
                                          authController.mail.value)) {
                                        await followController
                                            .unFollow(club.id);
                                        getFollowedEmails();
                                        await getClubById.getClubById(club.id!);
                                        Future.delayed(Duration(seconds: 5),
                                            () {
                                          print(getFollowedEmails());
                                        });
                                      } else {
                                        await followController.follow(club.id);
                                        getFollowedEmails();
                                        await getClubById.getClubById(club.id!);
                                        Future.delayed(Duration(seconds: 5),
                                            () {
                                          print(getFollowedEmails());
                                        });
                                      }
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      _showAlertDialog(context, club.name);
                                    }
                                    // print(getClubs());
                                  },
                                  icon: getFollowedEmails().contains(
                                                  authController.mail.value) &&
                                              authController.mail.value != '' ||
                                          getClubs().contains(
                                              authController.mail.value)
                                      ? const Icon(
                                          Icons.notifications_active_outlined,
                                        )
                                      : const Icon(
                                          Icons.notification_add_rounded,
                                        ),
                                ),
                              ),
                            ),
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

  RxBool following = false.obs;
}
// Rx<Availability> getOneDate() {
//     return stads.availability!
//         .firstWhere((element) =>
//             element.date!.substring(0, 10) ==
//             selectedDate.value.toString().substring(0, 10))
//         .obs;
//   }