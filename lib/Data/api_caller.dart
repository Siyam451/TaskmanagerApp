import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiCaller{
  Future<ApiResponse> getRequest({ required String Url})async {
    //uri ready
    try {
      Uri uri = Uri.parse(Url);
//body ready
      Response response = await get(uri);
      // debugPrint(Url);
      // debugPrint(response.statusCode);
      // debugPrint(response.body);

      final int statuscode = response.statusCode;
      //success
      if (statuscode == 200) {
        //success
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

  Future<ApiResponse> postRequest({ required String Url,required Map<String,dynamic>body})async {
    //post e body o lagbe tai
    //uri ready
    Uri uri = Uri.parse(Url);
//body ready
    Response response = await post(uri);
    // debugPrint(Url);
    // debugPrint(response.statusCode);
    // debugPrint(response.body);
    try {
      final int statuscode = response.statusCode;
      //success
      if (statuscode == 200 && statuscode == 201) {
        //success
        final decodedData = jsonDecode(response.body);
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
          errorMassage: '',
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
          isSuccess: false,
          responsecode: -1,
          responsedata:null,
        errorMassage: e.toString()

      );
    }
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