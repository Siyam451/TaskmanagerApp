import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ApiCaller{
  final Logger _logger = Logger();//obj create for logger
  Future<ApiResponse> getRequest({ required String Url})async { //function
    //uri ready
    try {
      Uri uri = Uri.parse(Url);
//body ready
      _logRequest(Url);

      Response response = await get(uri);

      _logResponse(Url, response);
      // debugPrint(Url);
      // debugPrint(response.statusCode);
      // debugPrint(response.body);

      final int statuscode = response.statusCode;
      //success
      if (statuscode == 200) {

        final decodedData = jsonDecode(response.body);//data must decoded kora lagbe
        return ApiResponse(isSuccess: true,
            responsecode: statuscode,
            responsedata: decodedData
        );
      } else {
        //failed
        final decodedData = jsonDecode(response.body);
        return ApiResponse(isSuccess: false,
          responsecode: statuscode,
          responsedata: decodedData,
          errorMassage: decodedData['data'],
        );
      }
    } on Exception catch (e) {// jdi error ashe tkn try catch er maddome shudu jeikane prblm oita off hbe
      return ApiResponse(isSuccess: false,
          responsecode: -1,
          responsedata:null,
          errorMassage: e.toString()
      );

    }
  }

  Future<ApiResponse> postRequest({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, body: body);

      Response response = await post(
        uri,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(body),
      );

      _logResponse(url, response);

      final int statuscode = response.statusCode;

      if (statuscode == 200 || statuscode == 201) {
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          responsecode: statuscode,
          responsedata: decodedData,
        );
      } else {
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          responsecode: statuscode,
          responsedata: decodedData,
          errorMassage: decodedData['message'] ?? 'Request failed',
        );
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        responsecode: -1,
        responsedata: null,
        errorMassage: e.toString(),
      );
    }
  }


  void _logRequest(String Url,{Map<String,dynamic>? body}){//request er somoy Url ar body dibo
    _logger.i(
      'URL => $Url\n'
          'Request body: $body',

    );
  }


  void _logResponse(String Url,Response response){//newar somoy url ar response nibo
    _logger.i(
        'URL => $Url\n'
      'Stutuscode : ${response.statusCode}\n'
        'body : ${response.body}'
    );


  }


  }



// amder ki ki lagbe ta fixed kortesi
class ApiResponse {
  final bool isSuccess;
  final int responsecode;
  final dynamic responsedata; //j kono type e responsedata ashte pare tai dynamic nichi
  final String? errorMassage;


  ApiResponse({
      required this.isSuccess,
      required this.responsecode,
      required this.responsedata,
      this.errorMassage = 'Something went wrong'

});

}