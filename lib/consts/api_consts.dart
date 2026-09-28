import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConsts{
  static final String mainUrl=    dotenv.env['mainUrl']!;
  static final String seconderyUrl= dotenv.env['seconderyUrl']!;
  static final String translateUrl= dotenv.env['translateUrl']!;
  static final String apiKey= dotenv.env['apiKey']!;
  static final String endPoint =  dotenv.env['endPoint']!;
  static final String baseUrl =  dotenv.env['baseUrl']!;
  static final  String modelName = dotenv.env['modelName']!;
  static final String baseUrlFoodFactor=  dotenv.env['baseUrlFoodFactor']!;

}
//https://world.openfoodfacts.org/api/v2/search?categories_tags_en=orange-juices&page_size=20&fields=product_name,brands,nutriments