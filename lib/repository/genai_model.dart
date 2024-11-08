import 'package:google_generative_ai/google_generative_ai.dart';

class GenAiModel {
  late final GenerativeModel _model;
  late final ChatSession _session;

  GenAiModel() {
    const apiKey = String.fromEnvironment('apiKey');

    _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: "AIzaSyDwW51nRVg5odhU8-gDN4RzgWKjiA4QW-w");
    _session = _model.startChat();
  }

  Future<GenerateContentResponse> sendMessage(Content content) =>
      _session.sendMessage(content);
}
