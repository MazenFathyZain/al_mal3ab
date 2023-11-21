import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kora/model/club.dart';
import 'package:kora/view/stad_detailes_screen.dart';

class StadsScreen extends StatelessWidget {
  final List<Stadiums> stads;

  const StadsScreen({super.key, required this.stads});

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(stads[0].photos![0]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("الملاعب"),
      ),
      body: ListView.builder(
          itemCount: stads.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(
                  StadDetailes(
                    stads: stads[index],
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: MemoryImage(bytes),
                  ),
                  title: Text(stads[index].name!),
                  trailing: Text(stads[index].size!.toString()),
                ),
              ),
            );
          }),
    );
  }
}
