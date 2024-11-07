import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpUtils {

  Future<http.Response> post(String uri, Map<String, String> headers, Object request) async{
   try{
     final response = await http.post(
       Uri.parse(uri),
       headers: headers,
       body: jsonEncode(request),
     );
     return response;
   }catch(error){
     throw Exception('Error making request: $error');
   }
  }
  Future<http.Response> delete(String uri, Map<String, String> headers, Object request) async{
    try{
      final response = await http.delete(
        Uri.parse(uri),
        headers: headers,
        body: jsonEncode(request),
      );
      return response;
    }catch(error){
      throw Exception('Error making request: $error');
    }
  }
}