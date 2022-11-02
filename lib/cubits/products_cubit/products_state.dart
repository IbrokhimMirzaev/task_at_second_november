part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class GetProductsInProgress extends ProductsState {}

class GetProgressInSuccess extends ProductsState {
  GetProgressInSuccess({required this.products});

  final List<ProductItem> products;
}

class GetProgressInFailure extends ProductsState {
  GetProgressInFailure({required this.errorText});

  final String errorText;
}
