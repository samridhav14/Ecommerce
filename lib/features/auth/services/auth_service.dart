import 'package:amazon/constants/error_handeling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // sign up with email and password
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          type: '',
          token: '');
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
     httpErrorHandel(res: res, context: context, onSucces: (){
       showSnackBar(message:'Account created successfully! Login with the same credentials', context: context);
     });
    } catch (e) {
      showSnackBar(message: (e).toString(), context: context);
    }
  }
}
