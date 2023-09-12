import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kora/constants.dart';
import 'package:kora/controller/location.dart';
import 'package:get/get.dart';

import '../controller/club_web_services.dart';
import 'widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Location().getLocation();
    super.initState();
  }

  ClubWebServices clubCotroller = Get.put(ClubWebServices());
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
      body: 
      
     GetBuilder<ClubWebServices>(
        builder: (controller) {
          if (controller.dataList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: controller.dataList.length,
              itemBuilder: (context, index) {
                final item = controller.dataList[index];
                return ListTile(
                  title: Text(item.name),
                );
              },
            );
          }
        },
      ),
    );
  }
}



// Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
//         child: Column(
//           children: [
//             const SizedBox(height: 3),
//             search(),
//             const SizedBox(height: 15),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade200),
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.white,
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 // mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Image.asset(
//                       "assets/image.jfif",
//                       height: 120,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                         clubCotroller.getAllClubs(),
//                           style: GoogleFonts.righteous().copyWith(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           "القاهره - المقطم",
//                           style: GoogleFonts.righteous().copyWith(
//                             fontSize: 13,
//                           ),
//                         ),
//                         Text(
//                           "250 ج.م",
//                           style: GoogleFonts.righteous().copyWith(
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.bottomRight,
//                       child: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.favorite_border)),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
    


    