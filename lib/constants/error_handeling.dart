import 'dart:convert';

import 'package:amazon/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void httpErrorHandel({
   required http.Response res,
   required BuildContext context,
   required VoidCallback onSucces,
}){
  switch(res.statusCode){
    case 200:
      onSucces();
      break;
    case 400:
    showSnackBar(message: jsonDecode(res.body)['msg'], context: context);
      break;
    case 500:
      showSnackBar(message:jsonDecode(res.body)['error'], context: context);
      break;
    default:
     showSnackBar(message: res.body, context: context);
  }
}