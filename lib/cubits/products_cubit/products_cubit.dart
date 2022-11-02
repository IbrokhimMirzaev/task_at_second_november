import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_at_second_november/data/models/product/product_item.dart';
import 'package:task_at_second_november/data/services/api_services.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required this.apiProvider}) : super(ProductsInitial()) {
    getAllProducts();
  }

  final ApiProvider apiProvider;

  Future<void> getAllProducts() async {
    emit(GetProductsInProgress());
    try {
      var products = await apiProvider.getAllProducts();
      emit(GetProgressInSuccess(products: products));
    }
    catch (e){
      emit(GetProgressInFailure(errorText: e.toString()));
    }
  }
}
