import 'dart:io';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class JokeSaveUtil{

  JokeSaveUtil();

   Future<ui.Image> textToImage(GlobalKey key) async{
      RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
      return boundary.toImage();
  }

  saveText(ui.Image image, String fileName) async{

      String name = fileName+'.png';
      var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      String directoryPath = await appDirectoryPath();
      File imgFile =new File('$directoryPath/$name');
      imgFile.writeAsBytes(pngBytes);
  }

  saveImage(String imageUrl, String fileName, extension) async{
        String name = fileName+extension;
        String directoryPath = await appDirectoryPath();
        await Dio().download(imageUrl, '$directoryPath/$name');
  }


  Future<String> appDirectoryPath() async{

    String appPath = (await getExternalStorageDirectory()).path+'/SitcomJokes';
    Directory appDirectory = Directory(appPath);
    if( !(await appDirectory.exists())){
        await appDirectory.create();
    }
    return appDirectory.path;
  }
}