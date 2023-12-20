import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kora/controller/admin_clubs.dart';
import 'package:kora/controller/delete_reservation.dart';
import 'package:kora/controller/pinned_reservation.dart';
import 'package:kora/controller/reservation.dart';
import 'package:kora/model/club.dart';
import 'package:intl/intl.dart';
import 'package:kora/view/admin_screens/admin_screen.dart';

// ignore: must_be_immutable
class AdminStadDetailes extends StatelessWidget {
  final Stadiums stads;
  final int stadIndex;
  final int clubId;
  final String? phone;
  AdminStadDetailes({
    super.key,
    required this.stads,
    required this.clubId,
    required this.stadIndex,
    this.phone,
  });

  Rx<DateTime> selectedDate = DateTime.now().obs;
  AdminClubs controller2 = Get.put(AdminClubs());
  Reservation reservationController = Get.put(Reservation());
  PinnedReservation pinnedController = Get.put(PinnedReservation());
  DeleteReservation deleteController = Get.put(DeleteReservation());
  final TextEditingController _name = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RxBool loading = false.obs;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('EEEE  d', 'ar_SA');
    // Uint8List bytes = base64Decode(stads.images![0].substring(23));
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
                // child: Image.memory(bytes, fit: BoxFit.fill),
                child: Image.asset(
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
                    selectedDate.value =
                        selectedDate.value.subtract(const Duration(days: 1));
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
                    selectedDate.value =
                        selectedDate.value.add(const Duration(days: 1));
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height * 45 / 100,
              child: SizedBox(
                child: GridView.builder(
                  itemCount: 24,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7,
                    crossAxisCount: 6,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String hour = '${index.toString().padLeft(2, '0')}:00';
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          print(
                              '${selectedDate.toString().substring(0, 10)}T$hour');
                          var name = stads.reservations!
                              .where((reservation) =>
                                  reservation.reservationTime! ==
                                          '${selectedDate.toString().substring(0, 10)}T$hour:00' &&
                                      reservation.status == 'RESERVED' ||
                                  reservation.reservationTime! ==
                                          '${selectedDate.toString().substring(0, 10)}T$hour:00' &&
                                      reservation.status == 'PINNNED')
                              .map((reservation) => reservation.playerName)
                              .toList();
                          getReservatedTimes().contains(hour)
                              ? _cancelTime(context, hour, name[0])
                              : _reserveTime(context, hour);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: getReservatedTimes().contains(hour)
                                ? const Color.fromARGB(255, 255, 72, 72)
                                : const Color.fromARGB(255, 110, 206, 113),
                            border: getReservatedTimes().contains(hour)
                                ? Border.all(color: Colors.red.shade100)
                                : Border.all(color: Colors.white),
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

  void _showDatePicker(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(), //.add(const Duration(days: 13))
      locale: const Locale('ar', 'SA'), // Set the Arabic locale
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      print('Selected date: $pickedDate');
      getReservatedTimes();
    }
  }

  Future<void> _reserveTime(BuildContext context, time) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => loading.value
              ? const Center(child: CircularProgressIndicator())
              : AlertDialog(
                  title: Text('حجوزات ملعب ${stads.name!}'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('هل تريد حجز الساعه $time'),
                        Text(
                            '${selectedDate.toString().substring(0, 10)} من تاريخ'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _name,
                            decoration: const InputDecoration(
                              labelText: 'إسم اللاعب',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "يجب إدخال اسم اللاعب ";
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('إالغاء'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  loading.value = true;
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    await pinnedController.pinned(
                                        stads.id,
                                        '${selectedDate.toString().substring(0, 10)}T$time',
                                        _name.text);
                                    AdminClubs controller2 =
                                        Get.put(AdminClubs());
                                    await controller2.getClubs();
                                    Get.offAll(() => AdminScreen());
                                  }
                                  loading.value = false;
                                },
                                child: const Text('تثبيت'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  loading.value = true;
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    await reservationController.reserve(
                                        stads.id,
                                        '${selectedDate.toString().substring(0, 10)}T$time',
                                        _name.text);
                                    AdminClubs controller2 =
                                        Get.put(AdminClubs());
                                    await controller2.getClubs();
                                    Get.offAll(() => AdminScreen());
                                  }
                                  loading.value = false;
                                },
                                child: const Text('حجز'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Future<void> _cancelTime(BuildContext context, time, name) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => loading.value
              ? const Center(child: CircularProgressIndicator())
              : AlertDialog(
                  title: Text('حجوزات ${stads.name!}'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('هل تريد إالغاء الساعه $time الخاصة ب $name'),
                        Text(
                            '${selectedDate.toString().substring(0, 10)} من تاريخ'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () async {
                        loading.value = true;
                        var id = stads.reservations!
                            .where((reservation) =>
                                reservation.reservationTime! ==
                                        '${selectedDate.toString().substring(0, 10)}T$time:00' &&
                                    reservation.status == 'RESERVED' ||
                                reservation.reservationTime!.substring(0, 10) ==
                                        selectedDate.value
                                            .toString()
                                            .substring(0, 10) &&
                                    reservation.status == 'PINNED')
                            .map((reservation) => reservation.id)
                            .toList();
                        await deleteController.deleteReservation(id[0]);
                        await controller2.getClubs();
                        // controller2.updateItem(
                        //     clubId, stadIndex, 0, 'RESERVED');
                        Get.offAll(() => AdminScreen());
                        loading.value = false;
                      },
                      child: const Text('إلغاء الحجز'),
                    ),
                  ],
                ),
        );
      },
    );
  }

  RxList<String?> getReservatedTimes() {
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
}
