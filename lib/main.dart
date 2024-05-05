import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:unsplash_getx/config/root_binding.dart';

import 'package:unsplash_getx/pages/collection_page.dart';
import 'package:unsplash_getx/pages/collection_photos.dart';
import 'package:unsplash_getx/pages/details_page.dart';
import 'package:unsplash_getx/pages/home_page.dart';
import 'package:unsplash_getx/pages/search_page.dart';
import 'package:unsplash_getx/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: const SplashPage(),
     initialBinding:RootBinding(),
      routes: {
        SplashPage.id: (context) => const SplashPage(),
        HomePage.id: (context) => const HomePage(),
        SearchPage.id: (context) => const SearchPage(),
        CollectionPage.id: (context) => const CollectionPage(),
        CollectionPhotosPage.id: (context) => const CollectionPhotosPage(),
        DetailsPage.id: (context) => DetailsPage(),
      },
    );
  }
}

