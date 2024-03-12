import 'dart:convert';

import 'package:amazon/constants/error_handeling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/home/home_screen.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      httpErrorHandel(
          res: res,
          context: context,
          onSucces: () {
            showSnackBar(
                message:
                    'Account created successfully! Login with the same credentials',
                context: context);
          });
    } catch (e) {
      showSnackBar(message: (e).toString(), context: context);
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandel(
          res: res,
          context: context,
          onSucces: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // set user provider with the user data from the response body
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName, (route) => false);
            }
          });
    } catch (e) {
      showSnackBar(message: (e).toString(), context: context);
    }
  }
  // get user data
  void getUserData({
  required BuildContext context,
}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    // if token is null set it to empty string
    if (token == null) {
      prefs.setString('x-auth-token', '');
    }
    var tokenRes = await http.post(
      Uri.parse('$uri/tokenIsValid'),
         headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':token!
        },
    );
     var response=jsonDecode(tokenRes.body);
     if(response==true){
      // get user data
      http.Response userRes = await http.get(
        Uri.parse('$uri/api/user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );
     Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
    //  UserProvider().setUser(userRes.body);
     }
  } catch (e) {
   showSnackBar(message: (e).toString(), context: context);
  }
}

}


 