import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_at_second_november/cubits/file_cubit/file_manager_cubit.dart';
import 'package:task_at_second_november/cubits/products_cubit/products_cubit.dart';
import 'package:task_at_second_november/data/services/api_client.dart';
import 'package:task_at_second_november/data/services/api_services.dart';
import 'package:task_at_second_november/ui/products_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var client = ApiClient();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
          create: (context) => ProductsCubit(
            apiProvider: ApiProvider(apiClient: client),
          ),
        ),
      ],
      child: const MaterialApp(
        home: ProductsPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
