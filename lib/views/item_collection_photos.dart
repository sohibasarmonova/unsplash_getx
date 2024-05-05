import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_getx/controllers/collection_photos_controller.dart';
import 'package:unsplash_getx/models/collections_photos.dart';
import 'package:unsplash_getx/sericees/log_service.dart';

Widget itemOfCollectionPhotos(CollectionsPhotos photos,CollectionPhotosController collectionPhotosController) {
  return Hero(
    tag: photos.id,
    child: AspectRatio(
      aspectRatio: photos.width.toDouble() / photos.height.toDouble(),
      child: GestureDetector(
        onTap: () {
          collectionPhotosController.callDetailsPage(collectionPhotosController.getPhoto(photos));
          LogService.i(photos.description.toString());
        },
        child: Container(
          margin: const EdgeInsets.only(top: 5, left: 5),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: photos.urls.regular,
            placeholder: (context, urls) => Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            errorWidget: (context, urls, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}


