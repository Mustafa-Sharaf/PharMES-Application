import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart 'as http;

String? token;
const String baseurl='http://192.168.43.63:8000/api/';
const String imgURL='http://192.168.43.63:8000';
class HttpHelper{

  static Future<Response> postData(

      {required String url, Map<String, dynamic>?body} )async{
    final box = GetStorage();
    final storedToken = box.read<String>('token');
    return await http.post(Uri.parse('$baseurl$url'), body: body,headers:{ 'Accept':'application/json',
      if (storedToken != null) 'Authorization': 'Bearer $storedToken',});
  }
  static Future<Response> gettData({required String url})async {
    final box = GetStorage();
    final storedToken = box.read<String>('token');
    return await http.get(
        Uri.parse('$baseurl$url'), headers: {
      if (storedToken != null) 'Authorization': 'Bearer $storedToken',
    });
  }
  getData(String url)async {
    try {
      var response =await http.get(Uri.parse('$baseurl$url'));
      if (response.statusCode==200||response.statusCode==201){

        var responsebody=jsonDecode(response.body);
        return responsebody;
      }else{
        print('error ${response.statusCode}');

      }}
    catch (e){
      print('error catch $e');
    }
  }
  static Future<Response> uploadProfile({
    required String url,
    required Map<String, String> fields,
    required File file,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseurl$url'));
    request.fields.addAll(fields);
    request.headers.addAll({
      'Accept': 'application/json',
      "Authorization": 'Bearer $token',
    });
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    var response = await request.send();
    return await http.Response.fromStream(response);
  }

}









