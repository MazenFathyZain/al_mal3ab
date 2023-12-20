import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kora/constants.dart';
import 'package:kora/controller/location_controller.dart';
import 'package:kora/model/club.dart';
import 'package:intl/intl.dart';

class StadDetailes extends StatelessWidget {
  final Stadiums stads;
  final String? phone;
  StadDetailes({
    super.key,
    required this.stads,
    this.phone,
  });

  Rx<DateTime> selectedDate = DateTime.now().obs;

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
      reservatedTimes();
      print(reservatedTimes());
    }
  }

  RxList<String?> reservatedTimes() {
    List<String?> reservationTimes = stads.reservations!
        .where(
          (reservation) =>
              reservation.reservationTime!.substring(0, 10) ==
                      selectedDate.value.toString().substring(0, 10) &&
                  reservation.status == 'RESERVED' ||
              reservation.reservationTime!.substring(0, 10) ==
                      selectedDate.value.toString().substring(0, 10) &&
                  reservation.status == 'PINNED',
        )
        .map((reservation) => reservation.reservationTime!.substring(11, 16))
        .toList();
    return reservationTimes.obs;
  }

  nextDate() {
    selectedDate.value = selectedDate.value.add(const Duration(days: 1));
  }

  lasttDate() {
    selectedDate.value = selectedDate.value.subtract(const Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('EEEE  d', 'ar_SA');
    var image = stads.images![0];

    Uint8List bytes =
        base64Decode(image != '' ? stads.images![0].substring(23) : '');

    return Scaffold(
      appBar: AppBar(
        title: Text(stads.name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 27 / 100,
              width: double.infinity,
              child: ClipRRect(
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    lasttDate();
                  },
                ),
                TextButton(
                  onPressed: () {
                    _showDatePicker(context);
                  },
                  child: Obx(
                    () => Text(
                      formatter.format(selectedDate.value),
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    nextDate();
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height * 45 / 100,
              child: Expanded(
                child: GridView.builder(
                  itemCount: 24,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7,
                    crossAxisCount: 6,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String hour = '${index.toString().padLeft(2, '0')}:00';
                    return Obx(
                      () => Container(
                        // margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: reservatedTimes().contains(hour)
                              ? const Color.fromARGB(255, 255, 72, 72)
                              : const Color.fromARGB(255, 110, 206, 113),
                          border: reservatedTimes().contains(hour)
                              ? Border.all(color: Colors.red.shade100)
                              : Border.all(color: Colors.white),
                          // Color(0xffF2F4F7)
                          // borderRadius: BorderRadius.circular(14),
                        ),
                        child: SizedBox(
                          child: Center(
                              child: Text(
                            hour,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 // style: ButtonStyle(
                  //   fixedSize: MaterialStateProperty.all<Size>(
                  //     const Size(double.infinity, 40), // width and height
                  //   ),
                  // ),