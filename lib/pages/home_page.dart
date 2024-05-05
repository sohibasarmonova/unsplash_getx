import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unsplash_getx/controllers/home_controller.dart';



class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder <HomeController>(builder: (_) {
      return
      Scaffold(
        body:
        Center(
          child:homeController. pages.elementAt(homeController.selectedIndex),


        ),
        bottomNavigationBar: NavigationBar(
          height: 70,
          elevation: 0,
          selectedIndex: homeController.selectedIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: ''),
            NavigationDestination(icon: Icon(Iconsax.category_2), label: ''),
          ],
          onDestinationSelected: homeController.onItemTapped,
        ),
      );
    });
  }
}