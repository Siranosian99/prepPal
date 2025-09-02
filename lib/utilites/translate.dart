import 'package:translator/translator.dart';

Future<String> translateData(String input, String lang) async {
  final translator = GoogleTranslator();

  final translation = await translator.translate(
    input,
    from: 'en',
    to: lang,
  );

  return translation.text;
}
