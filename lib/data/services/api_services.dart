import 'package:dio/dio.dart';
import 'package:task_at_second_november/data/models/product/product_item.dart';
import 'api_client.dart';

class ApiProvider {
  final ApiClient apiClient;

  ApiProvider({required this.apiClient});

  Future<List<ProductItem>> getAllProducts() async {
    Response response = await apiClient.dio.get(apiClient.dio.options.baseUrl);
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      List<ProductItem> products = (response.data["data"] as List?)?.map((e) => ProductItem.fromJson(e)).toList() ?? [];
      return products;
    } else {
      throw Exception();
    }
  }
}
