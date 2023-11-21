import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kora/model/user.dart';

class Detailes extends StatelessWidget {
  final Stadiums stads;

  final String? phone;
  Detailes({
    super.key,
    required this.stads,
    this.phone,
  });

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
      getOneDate();
    }
  }

  Rx<Availability> getOneDate() {
    return stads.availability!
        .firstWhere((element) =>
            element.date!.substring(0, 10) ==
            selectedDate.value.toString().substring(0, 10))
        .obs;
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('EEEE, MMMM d', 'ar_SA');
    Uint8List bytes = base64Decode(stads.photos![0]);
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
              child: Image.memory(
                bytes,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _showDatePicker(context);
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(double.infinity,
                      48.0), // Set the desired width and height
                ),
              ),
              child: Obx(
                () => Text(
                  formatter.format(selectedDate.value),
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 45 / 100,
                child: Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: List.generate(24, (index) {
                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            _showAlertDialog(context, index);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: getOneDate().value.slots![index].status ==
                                      'free'
                                  ? Colors.green[200]
                                  : Colors.red[200],
                              border: getOneDate().value.slots![index].status ==
                                      'free'
                                  ? Border.all(color: Colors.green)
                                  : Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: Text(
                              "${getOneDate().value.slots![index].hour}:00",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            )),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert Dialog"),
          content: Text("This is an example of Flutter AlertDialog."),
          actions: <Widget>[
            TextButton(
              child: const Text("إلغاء الحجز"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("حجز"),
              onPressed: () {
                saveChanges(index); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void saveChanges(index) {
    String newTitle = 'booked';
    // Update the local data
    getOneDate().value.slots![index].status = newTitle;

    // Update the API data by sending a PUT request
    final dio = Dio();
    dio.patch(
        'http://localhost:8000/api/user${getOneDate().value.slots![index].status = newTitle}',
        data: {
          'status': newTitle,
        });

    Get.back(); // Return to the previous screen
  }
}
