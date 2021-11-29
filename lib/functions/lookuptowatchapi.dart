import 'dart:convert';

import 'package:dio/dio.dart' as dio;

Future<Map<String, dynamic>> lookupToWatchAPI({required String id}) async{

  var response = await dio.Dio().get(
    'https://utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com/idlookup?source_id=$id&source=imdb',
    options: dio.Options(
        headers: {
          "Accept" : "*/*",
          "Accept-Encoding" : "gzip, deflate, br",
          "Connection" : "keep-alive",
          "x-rapidapi-host" : "utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com",
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
