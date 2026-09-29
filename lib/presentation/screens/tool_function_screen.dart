import 'package:dio/dio.dart';
import 'package:dio_retry_interceptor/dio_retry_interceptor.dart';
import 'package:flutter/material.dart';

import '../../consts/api_consts.dart';

class ToolScreen extends StatefulWidget {
  const ToolScreen({super.key});

  @override
  State<ToolScreen> createState() => _ToolScreenState();
}

class _ToolScreenState extends State<ToolScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: const Text('Tool Screen'),),
      body:Column(
        children: [
          TextButton(onPressed: (){
            ToolApi().ToolFunction();
          }, child: const Text("Press Me"),),
        ],
      ),
    );
  }
}
String getVersionOfApp(){
  return "V1.0.0";
}

class ToolApi{
  final tools = [
    {
      "type": "function",
      "function": {
        "name": "get_app_version",
        "description": "Returns the current version of the Flutter application.",
        "parameters": {
          "type": "object",
          "properties": {},
        },
      },
    },
    {
      "type": "function",
      "function": {
        "name": "get_current_time",
        "description": "Returns the current local date and time.",
        "parameters": {
          "type": "object",
          "properties": {},
        },
      },
    },
  ];
  final Dio _dio3 = Dio(
    BaseOptions(
      baseUrl: ApiConsts.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )
    ..interceptors.add(
      RetryOnConnectionChangeInterceptor(
        Dio(),
        maxRetryAttempts: 1,
        retryPost: false,
        enableLogging: true,
      ),
    );
   Future<void> ToolFunction() async {
    // List<AiRecipeModel> recipes = [];
    try {
      final response = await _dio3.post(
        ApiConsts.endPoint,
        data: {
          "model": ApiConsts.modelName,
          "messages": [
            {"role": "user", "content": "What version is this app?"},
          ],
          "tools": tools,

        },
        options: Options(
          headers: {
            "Authorization": ApiConsts.apiKey,
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final content =        data["choices"][0]["message"]["tool_calls"][0];
        String executeTool(String functionName) {
          switch (functionName) {
            case "get_app_version":
              return getAppVersion();

            case "get_current_time":
              return getCurrentTime();

            default:
              throw Exception("Unknown tool: $functionName");
          }
        }
        print('----data:$data');
        print("----content:$content");
        return ;
        // final jsonData = jsonDecode(content);
        // final lastData = AiRecipeModel.fromJson(jsonData);
        // print('-==--------');
        // print(jsonEncode(lastData.toJson()));
        // recipes.add(
        //   AiRecipeModel(
        //     name: lastData.name,
        //     ingredients: lastData.ingredients,
        //     duration: lastData.duration,
        //     difficulty: lastData.difficulty,
        //     steps: lastData.steps,
        //   ),
        // );

      }

      // throw Exception("Unexpected status code: ${response.statusCode}");
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      debugPrint("DioException");
      debugPrint("Status Code: $statusCode");
      debugPrint("Message: ${e.message}");
      debugPrint("Response: ${e.response?.data}");

      final bool shouldRetry =
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError ||
          statusCode == 500 ||
          statusCode == 502 ||
          statusCode == 503 ||
          statusCode == 504;
    } catch (e) {
      debugPrint("Unexpected error: $e");
      throw Exception("Something went wrong.");
    }
    return null;
  }
}
//     data: {
//           "model": ApiConsts.modelName,
//           "messages": [
//             {
//               "role": "system",
//               "content":
//                   "You are a recipe generator. Generate recipes based on the user's available ingredients.",
//             },
//             {"role": "user", "content": query},
//           ],
//           "response_format": {
//             "type": "json_schema",
//             "json_schema": {
//               "name": "recipe",
//               "strict": true,
//               "schema": {
//                 "type": "object",
//                 "properties": {
//                   "name": {"type": "string"},
//                   "ingredients": {
//                     "type": "array",
//                     "items": {"type": "string"},
//                   },
//                   "duration": {"type": "integer"},
//                   "difficulty": {
//                     "type": "string",
//                     "enum": ["easy", "medium", "hard"],
//                   },
//                   "steps": {
//                     "type": "array",
//                     "items": {"type": "string"},
//                   },
//                 },
//                 "required": [
//                   "name",
//                   "ingredients",
//                   "duration",
//                   "difficulty",
//                   "steps",
//                 ],
//                 "additionalProperties": false,
//               },
//             },
//           },
//         },