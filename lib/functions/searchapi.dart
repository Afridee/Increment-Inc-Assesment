import 'dart:convert';

import 'package:dio/dio.dart' as dio;

Future<Map<String, dynamic>> searchAPI({required String query}) async{

  var response = await dio.Dio().get(
    'https://imdb8.p.rapidapi.com/auto-complete?q=$query',
    options: dio.Options(
        headers: {
          "Accept" : "*/*",
          "Accept-Encoding" : "gzip, deflate, br",
          "Connection" : "keep-alive",
          "x-rapidapi-host" : "imdb8.p.rapidapi.com",
          "x-rapidapi-key" : "ec7c97099amshef4ce11cc649305p15889fjsn8810316b769b"
        }
    ),
  );


  Map<String, dynamic> responseJSON = jsonDecode(response.toString());

  if(response.statusCode==200){
    return responseJSON;
  }else{
    return {
      "error" : responseJSON
    };
  }
}
