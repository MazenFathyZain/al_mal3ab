import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kora/model/club.dart';
import 'package:kora/view/admin_screens/admin_stad_detailes_screen.dart';

class AdminStadsScreen extends StatelessWidget {
  final List<Stadiums> stads;
  final int stadIndex;
  final int clubId;

  const AdminStadsScreen({
    super.key,
    required this.stads,
    required this.clubId,
    required this.stadIndex,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("الملاعب"),
      ),
      body: ListView.builder(
          itemCount: stads.length,
          itemBuilder: (context, index) {
            // Uint8List bytes =
            //     base64Decode(stads[index].images![0].substring(23));
            return GestureDetector(
              onTap: () {
                Get.to(
                  () => AdminStadDetailes(
                    stadIndex: index,
                    clubId: clubId,
                    stads: stads[index],
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Hero(
                      tag: stads[index].id!,
                      child: SizedBox(
                        height: 250,
                        width: width,
                        child: Image.asset(
                          'assets/image.jpg',
                          fit: BoxFit.fill,
                        ),
                        // child: Image.memory(
                        //   bytes,
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 44,
                        ),
                        child: Column(
                          children: [
                            Text(
                              stads[index].name!,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
