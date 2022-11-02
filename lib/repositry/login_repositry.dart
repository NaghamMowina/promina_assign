import 'package:promina_assign/data/network/network_api_service.dart';
import 'package:promina_assign/model/login_model.dart';

import '../res/app_url.dart';

class LoginRepositry {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<LoginModel> login(email, pass) async {
    try {
      dynamic response = await _apiServices
          .getPostApiResponse(AppUrl.login, {'email': email, 'password': pass});
      print('response $response');
      return response = LoginModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
