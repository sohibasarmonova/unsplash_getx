

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unsplash_getx/controllers/search_controller.dart';
import 'package:unsplash_getx/sericees/http_service.dart';
import 'package:unsplash_getx/sericees/log_service.dart';
import 'package:unsplash_getx/views/item_phots.dart';
import 'package:unsplash_getx/views/item_search_photos.dart';
import '../models/details_photo.dart';
import '../models/photos.dart';
import '../models/search_photos.dart';

import 'details_page.dart';

class SearchPage extends StatefulWidget {
  static const String id = 'search_page';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchesController = Get.find<SearchesController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   searchesController. apiPhotos();
    searchesController.photosScrollController.addListener(() {
      if (searchesController.photosScrollController.position.maxScrollExtent <=
         searchesController. photosScrollController.offset) {
        searchesController.currentPhotosPage++;
        searchesController.apiPhotos();
      }
    });

    if (searchesController.query != null) {
      searchesController.apiSearchPhotos(searchesController.query);
    }

   searchesController. searchPhotosScrollController.addListener(() {
      if (searchesController.searchPhotosScrollController.position.maxScrollExtent <=
         searchesController. searchPhotosScrollController.offset) {
       searchesController. currentSearchPhotosPage++;
        searchesController.apiSearchPhotos(searchesController.query);
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchesController>(builder: (_){
      return Scaffold(
        // search bar
        appBar: AppBar(
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                width: 1,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            child: TextField(
              onSubmitted: (value) {
                if(value == ''){
                  searchesController.photos.clear();
                  searchesController. apiPhotos();
                }else{
                  searchesController.searchesPhotos();
                }
              },
              // onChanged: (value){
              //   if(value == ''){
              //     _apiPhotos();
              //   }else{
              //     _searchPhotos();
              //   }
              // },
              textAlignVertical: TextAlignVertical.top,
              controller: searchesController.queryController,
              decoration: InputDecoration(
                hintText: "Search photos, collections, users",
                hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                border: InputBorder.none,
                prefixIcon: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Icon(Iconsax.search_normal),
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            (  searchesController.query == null)
                ?RefreshIndicator(
              onRefresh: searchesController.handleRefresh,
              child: Container(
                padding: const EdgeInsets.only(right: 5),
                child: MasonryGridView.count(
                  controller: searchesController.photosScrollController,
                  itemCount:searchesController. photos.length,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return itemOfPhotos(searchesController.photos[index],searchesController);
                  },
                ),
              ),
            )
                : RefreshIndicator(
              onRefresh: searchesController.handleRefresh,
              child: searchesController.searchPhotos.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                        image: const DecorationImage(
                          colorFilter:
                          ColorFilter.srgbToLinearGamma(),
                          image:
                          AssetImage('assets/images/no_data.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text('Nothing to see here...')
                  ],
                ),
              )
                  : Container(
                padding: const EdgeInsets.only(right: 5),
                child: MasonryGridView.count(
                  controller: searchesController.searchPhotosScrollController,
                  itemCount: searchesController.searchPhotos.length,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return itemOfSearchPhotos(searchesController.searchPhotos[index],searchesController);
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }





}