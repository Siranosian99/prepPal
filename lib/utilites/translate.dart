import 'package:translator/translator.dart';

void translateData(String input,String lang) async {
  final translator = GoogleTranslator();

  // final input = "Здравствуйте. Ты в порядке?";

  translator.translate(input, from: 'en', to: lang).then(print);
  // prints Hello. Are you okay?

  // var translation = await translator.translate("Dart is very cool!", to: 'pl');
  // print(translation);
  // // prints Dart jest bardzo fajny!

  // print(await "example".translate(to: 'pt'));
  // prints exemplo
}