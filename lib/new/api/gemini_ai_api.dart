import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:paysa/new/api/api_keys.dart';

class GeminiAiApi {
  final model =
      GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: ApiKeys.gemini);

  Future<String> generateText(String prompt) async {
    final content = [Content.text(prompt)];
    GenerateContentResponse response = await model.generateContent(content);

    return response.text ?? "";
  }

  // get streamed response generator for prompt
  Stream<String> generateTextStream(String prompt) async* {
    final content = [Content.text(prompt)];
    await for (GenerateContentResponse response
        in model.generateContentStream(content)) {
      yield response.text ?? "";
    }
  }
}
