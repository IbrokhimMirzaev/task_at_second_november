import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_at_second_november/cubits/file_cubit/file_manager_cubit.dart';
import 'package:task_at_second_november/cubits/products_cubit/products_cubit.dart';
import 'package:task_at_second_november/data/models/file/file_info.dart';
import 'package:task_at_second_november/data/services/api_client.dart';
import 'package:task_at_second_november/ui/widgets/product_item_view.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is GetProductsInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetProgressInSuccess) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              children: List.generate(
                state.products.length,
                (index) {
                  var pr = state.products[index];
                  return BlocProvider(
                    create: (context) => FileManagerCubit(apiClient: ApiClient()),
                    child: BlocBuilder<FileManagerCubit, FileManagerState>(
                      builder: (context, state) {
                        return ProductItemView(
                          isVisible: state.newFileLocation.isNotEmpty,
                          progress: state.progress,
                          icon: state.newFileLocation.isEmpty ? const Icon(Icons.download) : const Icon(Icons.download_done),
                          pr: pr,
                          onSaveTap: () {
                            if (state.newFileLocation.isEmpty){
                              var fileInfo = FileInfo(
                                fileName: pr.name,
                                fileUrl: pr.fileUrl,
                                progress: 0.0,
                              );

                              context.read<FileManagerCubit>().downloadIfExists(fileInfo: fileInfo);
                            }
                            else {
                              context.read<FileManagerCubit>().openFile();
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else if (state is GetProgressInFailure) {
            return Center(child: Text("Error occured: ${state.errorText}"));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
