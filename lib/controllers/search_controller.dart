import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unsplash_getx/models/details_photo.dart';
import 'package:unsplash_getx/models/photos.dart';
import 'package:unsplash_getx/pages/details_page.dart';
import 'package:unsplash_getx/sericees/http_service.dart';
import 'package:unsplash_getx/sericees/log_service.dart';

import '../models/search_photos.dart';

class SearchesController extends GetxController{

  bool isLoading = true;
  DetailsPhoto? detailsPhoto;
  String? query;
  List<Photo> photos = [];
  List<SearchPhoto> searchPhotos = [];
  ScrollController photosScrollController = ScrollController();
  ScrollController searchPhotosScrollController = ScrollController();
  int currentPhotosPage = 1;
  int currentSearchPhotosPage = 1;



  final TextEditingController queryController = TextEditingController();

  apiPhotos() async {
    try {

      var response =
      await Network.GET(Network.API_PHOTOS, Network.paramsPhotos(currentPhotosPage));

        photos.addAll (Network.parsePhotosList(response!));
        isLoading = false;
      update();
      LogService.d(photos.length.toString());
    } catch (e){
      LogService.e(e.toString());
    }
  }

  apiSearchPhotos(String? query) async {
    try {
      var response = await Network.GET(Network.API_SEARCH_PHOTOS,
          Network.paramsSearchPhotos(query!, currentSearchPhotosPage));

        searchPhotos.addAll((Network.parseSearchPhotos(response!)).searchPhotos);
        isLoading = false;
      update();
      LogService.d(searchPhotos.length.toString());
      query = null;
    } catch (e) {
      LogService.e(e.toString());
    }
  }


  void searchesPhotos() {
    searchPhotos.clear();
    query = queryController.text;
    apiSearchPhotos(query!);
  }

  callDetailsPage(DetailsPhoto photo) {
    Get.to(DetailsPage(detailsPhoto: photo));

  }

  DetailsPhoto getPhoto(Photo photo) {
    return DetailsPhoto(
      id: photo.id,
      createdAt: photo.createdAt,
      width: photo.width,
      height: photo.height,
      description: photo.description,
      urls: photo.urls,
      user: photo.user,
    );
  }

  DetailsPhoto getSearchPhoto(SearchPhoto searchPhoto) {
    return DetailsPhoto(
      id: searchPhoto.id,
      createdAt: searchPhoto.createdAt,
      width: searchPhoto.width,
      height: searchPhoto.height,
      description: searchPhoto.description,
      urls: searchPhoto.urls,
      user: searchPhoto.user,
    );
  }

  Future<void> handleRefresh() async {
    apiPhotos();
    photos.clear();
  }
}