import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:public_chat/repository/genai_model.dart';
import 'package:public_chat/service_locator/service_locator.dart';
import 'package:public_chat/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_manager_state.dart';

class LocalizationManagerCubit extends Cubit<LocalizationManagerState> {
  LocalizationManagerCubit() : super(const LocalizationManagerState());

  final sharedPref = ServiceLocator.instance.get<SharedPreferences>();

  void loadSavedLocale() {
    final savedLocaleString = sharedPref.getString('locale') ?? 'en';
    final savedLocale = Locale.fromSubtags(languageCode: savedLocaleString);
    emit(state.copyWith(locale: savedLocale));
  }

  void changeLocale(Locale? locale, String language) async {
    if (locale != null) {
      final result =
          await FirebaseFirestore.instance.collection('public').get();
      final messageJsonList = result.docs.map((e) => e.data()).toList();
      final response =
          await ServiceLocator.instance.get<GenAiModel>().sendMessage(
                Content.text(
                  Utils.getChangeLanguagePromtMessage(
                    messageList: messageJsonList,
                    newLanguageCode: locale.languageCode,
                    newLanguage: language,
                  ),
                ),
              );
      String? text = response.text;
      if (text != null) {
        text = Utils.formatGeneratedJsonString(text);
        final newJson = jsonDecode(text);
        if (newJson is List) {
          for (int i = 0; i < newJson.length; i++) {
            final originalDoc = result.docs[i];
            final newMessage = newJson[i]['message'];
            if (newMessage != null) {
              await originalDoc.reference.update({
                'message': newMessage,
              });
            }
          }
        }
      }
      emit(state.copyWith(locale: locale));
      sharedPref.setString('locale', locale.languageCode);
    }
  }
}
