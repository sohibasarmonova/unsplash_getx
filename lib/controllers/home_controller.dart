import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unsplash_getx/pages/collection_page.dart';
import 'package:unsplash_getx/pages/search_page.dart';

class HomeController extends GetxController{
  List<Widget> pages = <Widget>[
    const SearchPage(),
    const CollectionPage(),
  ];

  int selectedIndex = 0;

  void onItemTapped(int index) {

      selectedIndex = index;
    update();
  }
}