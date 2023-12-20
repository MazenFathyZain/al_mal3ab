import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kora/controller/auth_services.dart';
import 'package:kora/controller/following.dart';
import 'package:kora/controller/get_all_clubs.dart';
import 'package:kora/view/auth/login.dart';
import 'package:kora/view/stad_detailes_screen.dart';
import 'package:kora/view/stads_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  GetAllClubs clubController = Get.put(GetAllClubs());
  Follow followController = Get.put(Follow());
  AuthServices authController = Get.put(AuthServices());
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
                  'لمتابعة $clubName والحصول على اشعارات يجب عليك تسجيل الدخول',
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
            onPressed: () {},
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
              onChanged: (query) {
                clubController.searchClubsByName(query);
                // Handle the search results as needed
                // You can update the UI or perform other actions based on the search results
              },
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'اكتب إسم الملعب',
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            search(),
            Expanded(
              child: Obx(() {
                if (clubController.searchResults.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: clubController.searchResults.length,
                    itemBuilder: (context, index) {
                      final club = clubController.searchResults[index];
                      RxList getFollowedEmails() {
                        if (club.followers!.isNotEmpty) {
                          RxList emails = club.followers!
                              .map((element) => element.user!.email)
                              .toList()
                              .obs;
                          return emails;
                        }
                        return [].obs;
                      }

                      var image = club.stadiums![0].images![0];
                      Uint8List bytes = base64Decode(image != ''
                          ? club.stadiums![0].images![0].substring(23)
                          : ''); //club.photos![0]);
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
                                          child: image != ''
                                              ? Image.memory(
                                                  bytes,
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.asset(
                                                  'assets/image.jpg',
                                                  fit: BoxFit.fill,
                                                ),
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
                                    if (token == null) {
                                      // ignore: use_build_context_synchronously
                                      _showAlertDialog(context, club.name);
                                    } else {
                                      if (getFollowedEmails().contains(
                                          authController.mail.toString())) {
                                        await followController
                                            .unFollow(club.id);
                                        await clubController.getclubs();
                                        getFollowedEmails();
                                        print(getFollowedEmails());
                                      } else {
                                        await followController.follow(club.id);
                                        await clubController.getclubs();
                                        getFollowedEmails();
                                        print(getFollowedEmails());
                                      }
                                    }
                                  },
                                  icon: getFollowedEmails().contains(
                                              authController.mail.toString()) ||
                                          authController.mail.value != 'null'
                                      ? const Icon(
                                          Icons.notifications_active_outlined)
                                      : const Icon(
                                          Icons.notification_add_rounded),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
