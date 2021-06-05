import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:google_sheets_flutter/model/form.dart';


class FormController {


  static const String URL = "https://script.google.com/macros/s/AKfycbwP767CKx2RFXTPPICi9OEU6GZiWpaoy538E7NkLMRSKokp3C5m/exec";


  static const STATUS_SUCCESS = "SUCCESS";


  void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      await http.post( Uri.parse(URL), body: feedbackForm.toJson()).then((response) async {
        if (response.statusCode == 302) {
          // ignore: non_constant_identifier_names
          var URL = response.headers['location'];
          await http.get( Uri.parse(URL)).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}