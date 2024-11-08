import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Utils {
  static Future<Locale?> convertCountryCodeToLocale(String country) async {
    try {
      var url = Uri.parse('https://restcountries.com/v3.1/alpha/$country');
      var response = await http.get(url);
      final json = jsonDecode(response.body) as List<dynamic>;
      final languages = json[0]?['languages'] as Map<String, dynamic>;
      return Locale.fromSubtags(
          languageCode: languages.keys.first.substring(0, 2));
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String getChangeLanguagePromtMessage(
      {required List<Map<String, dynamic>> messageList,
      required String newLanguageCode,
      required String newLanguage}) {
    return '''
      $messageList \n Check if there is no value for the key $newLanguageCode;
      if not, add a new field to the 'message' field,
      using $newLanguageCode as the key and translating the value of 'en' to $newLanguage.
      Then, return the updated JSON as plain text, including all the JSON contents,
      formatted only for the 'message' field while keeping all other fields unchanged.
    ''';
  }

  static String formatGeneratedJsonString(String json) {
    if (json.contains("```json")) {
      json = json.substring(7);
      json = json.substring(0, json.indexOf("`"));
    }
    return json;
  }
}
