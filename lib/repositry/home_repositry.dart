import 'package:promina_assign/data/response/api_response.dart';
import 'package:promina_assign/model/gallery_model.dart';
import 'package:promina_assign/model/upload_model.dart';
import 'package:http/http.dart' as http;

import '../data/network/network_api_service.dart';
import '../res/app_url.dart';

class HomeRepositry {
  final NetworkApiServices _apiServices = NetworkApiServices();
  Future<GalleryModel> getGallery() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.gallery);
      print('responsehomee $response');

      return response = GalleryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<UploadModel> uploadImage(img) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.upload,
          {'img': await http.MultipartFile.fromPath('img', img)});
      return response = UploadModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
