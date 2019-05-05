import 'package:dio/dio.dart';

class HttpUtil{

    Future<Response> sendGet({url, queryParameters}) async{

       try{
          Response response;
          Dio dio = new Dio();
          response = await dio.get("/test?id=12&name=wendu");
          print(response.data.toString());
          response = await dio.get("/test", queryParameters: queryParameters);
          print(response.data.toString());
          return response;
       }catch(err){
            throw Exception(err.toString());
       }
    }
    Future<Response> sendPost({url, data}) async{

       try{
          Response response;
          Dio dio = new Dio();
          response = await dio.get("/test?id=12&name=wendu");
          print(response.data.toString());
          response = await dio.post("/test", data: data);
          print(response.data.toString());
          return response;
       }catch(err){
         throw Exception(err.toString());
       }
    }
}