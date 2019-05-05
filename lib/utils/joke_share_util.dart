import 'package:share/share.dart';
import 'package:tv_series_jokes/models/joke.dart';


class JokeShareUtil{


  shareTextJoke(Joke joke){

    //Share.plainText(title:joke.title, text:joke.text);
    Share.share('(Sitcom jokes) - ${joke.title} -  ${joke.text}');
  }

  shareImageJoke(Joke joke) async{

    //  String name = joke.id+joke.getImageExtension();
    //  String directoryPath = await appDirectoryPath();

    // List<int> file = File('$directoryPath/$name').readAsBytesSync();
    // String imageString =  base64Encode(file);
    Share.share('(Sitcom jokes) - ${joke.title}'); 
  }

  //  Future<String> appDirectoryPath() async{

  //   String appPath = (await getExternalStorageDirectory()).path+'/SitcomJokes';
  //   Directory appDirectory = Directory(appPath);
  //   if( !(await appDirectory.exists())){
  //       await appDirectory.create();
  //   }
  //   return appDirectory.path;
  // }
}