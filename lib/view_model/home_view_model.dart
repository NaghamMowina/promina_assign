import 'package:flutter/material.dart';
import 'package:promina_assign/model/gallery_model.dart';

import '../data/response/api_response.dart';
import '../repositry/home_repositry.dart';

class HomeViewModel with ChangeNotifier {
  final _galleryRepo = HomeRepositry();

  ApiResponse<GalleryModel> imagesList = ApiResponse.loading();

  setGalleryList(ApiResponse<GalleryModel> response) {
    imagesList = response;
    notifyListeners();
  }

  Future<void> fetchImagesListApi() async {
    print('heyyyy');
    await _galleryRepo.getGallery().then((value) {
      setGalleryList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setGalleryList(ApiResponse.error(error.toString())));
  }
}
