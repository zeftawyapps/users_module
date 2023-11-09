
import 'i_http_urls.dart';

class BaseUrls extends HttpUrls {
  // create instance UsersHttpUrls
  static final BaseUrls _instance = BaseUrls._internal();

  String addPruductUrl = 'v1/products';
  String editPruductUrl = 'v1/products';

  BaseUrls({this.addPruductUrl = 'v1/products' , this.editPruductUrl = 'v1/products'}) {
      _instance;
  }
  BaseUrls._internal();


}