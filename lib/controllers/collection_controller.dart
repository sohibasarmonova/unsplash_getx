import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unsplash_getx/models/collections.dart';
import 'package:unsplash_getx/sericees/http_service.dart';
import 'package:unsplash_getx/sericees/log_service.dart';

import '../pages/collection_photos.dart';

class CollectionController extends GetxController{

  List<Collections> collections = [];
  ScrollController scrollController = ScrollController();
  int currentPage = 1;




apiCollections() async {
  try{
    var response = await Network.GET(Network.API_COLLECTIONS, Network.paramsCollections(currentPage));

      collections.addAll(Network.parseCollections(response!));
    update();
    LogService.d(collections.length.toString());
  } catch (e) {
    LogService.e(e.toString());
  }
}

callCallPhotosPage(Collections collection){
  Get.to(CollectionPhotosPage(collection: collection));

}

Future<void> handleRefresh() async {
  apiCollections();
  collections.clear();
}
}