import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_at_second_november/data/models/file/file_info.dart';
import 'package:task_at_second_november/data/services/api_client.dart';

part 'file_manager_state.dart';

class FileManagerCubit extends Cubit<FileManagerState> {
  FileManagerCubit({required this.apiClient}) : super(FileManagerState(progress: 0.0, newFileLocation: ""));

  final ApiClient apiClient;

  void downloadIfExists({required FileInfo fileInfo}) async {
    // permission
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return;

    var directory = await getDownloadPath();
    print("PATH :${directory?.path}");
    String url = fileInfo.fileUrl;
    String newFileLocation = "${directory?.path}/${fileInfo.fileName}${url.substring(url.length - 5, url.length)}";

    try {
      await apiClient.dio.download(url, newFileLocation, onReceiveProgress: (received, total) {
        var pr = received / total;
        emit(state.copyWith(progress: pr));
      });
      emit(state.copyWith(newFileLocation: newFileLocation));
    } catch (error) {
      debugPrint("DOWNLOAD ERROR:$error");
    }
  }

  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  Future<Directory?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        // from path_provider
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          // from path_provider
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      debugPrint("Cannot get download folder path");
    }
    return directory;
  }

  void openFile() {
    if (state.newFileLocation.isNotEmpty){
      print("OCHILDI: ${state.newFileLocation}");
      OpenFile.open(state.newFileLocation);
    }
  }
}
