import 'package:dio/dio.dart';
import 'package:dio_retry_interceptor/dio_retry_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../buisnes_logic/prep_pal_cubit.dart';
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
            ToolApi().toolFunction(context);
          }, child: const Text("Press Me"),),
        ],
      ),
    );
  }
}
String getAppVersion(){
  return "VARTAN SIRANOSIAN";
}

class ToolApi {
  final List<Map<String, dynamic>> tools = [
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
  ];

  final Dio _dio3 = Dio(
    BaseOptions(
      baseUrl: ApiConsts.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // -------------------------
  // REAL DART FUNCTIONS
  // -------------------------

  void getAppVersion(BuildContext context) {
   context.goNamed('settings');
  }



  // -------------------------
  // TOOL DISPATCHER
  // -------------------------

  void executeTool(String functionName,BuildContext context) async{
    if(functionName =="get_app_version" ){
      return context.read<PrepPalCubit>().removeFavouriteList2(0,context);
    }

  }

  // -------------------------
  // OPENROUTER REQUEST
  // -------------------------

  Future<void> toolFunction(BuildContext context) async {
    try {
      final response = await _dio3.post(
        ApiConsts.endPoint,
        data: {
          "model": ApiConsts.modelName,
          "messages": [
            {
              "role": "user",
              "content": "What version is this app?",
            },
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

      if (response.statusCode != 200) {
        throw Exception(
          "Unexpected status code: ${response.statusCode}",
        );
      }

      final data = response.data;

      // AI'ın gönderdiği tool call
      final toolCall =
      data["choices"][0]["message"]["tool_calls"][0];

      // Örneğin:
      // get_app_version
      final functionName =
      toolCall["function"]["name"];

      print("AI requested tool: $functionName");

      // Gerçek Dart function'ını çalıştır
      final result = executeTool(functionName,context);

      print("Tool result:s");
    } on DioException catch (e) {
      debugPrint("DioException");
      debugPrint("Status Code: ${e.response?.statusCode}");
      debugPrint("Message: ${e.message}");
      debugPrint("Response: ${e.response?.data}");
    } catch (e) {
      debugPrint("Unexpected error: $e");
    }
  }
}//     data: {
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