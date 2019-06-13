import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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
       
       String name = fileName+'.jpg';
       String directoryPath = await appDirectoryPath();
       final cacheManager = DefaultCacheManager();
       File file = await cacheManager.getSingleFile(imageUrl);

       List<int> fileBytes = await file.readAsBytes();
       File('$directoryPath/$name')..writeAsBytesSync(fileBytes);
       return true;
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