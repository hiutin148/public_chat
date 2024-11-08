import 'dart:convert';
import 'package:public_chat/models/entities/language_api_response.dart';
import 'package:http/http.dart' as http;
import 'package:public_chat/models/entities/language_entity.dart';

final class LanguageRepository {
  static LanguageRepository? _instance;
  List<LanguageEntity> _languages = [];
  LanguageRepository._();

  List<LanguageEntity> get languages => _languages;

  static LanguageRepository get instance {
    _instance ??= LanguageRepository._();
    return _instance!;
  }

  Future<void> getLanguages() async {
    try {
      var url = Uri.parse('https://global.metadapi.com/lang/v1/languages');
      var response = await http.get(url, headers: {
        "Ocp-Apim-Subscription-Key": "9e871ff47eff4efdab83e76e46b985c3"
      });
      final json = jsonDecode(response.body);
      final LanguageApiResponse languageApiResponse =
          LanguageApiResponse.fromJson(json);
      _languages = languageApiResponse.data ?? [];
    } catch (e) {
      print(e);
    }
  }
}
