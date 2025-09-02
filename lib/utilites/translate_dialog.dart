import 'package:flutter/material.dart';

void translateDialog(BuildContext context,String about,String area,String ingredient,String link) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
          ),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Title
                Text(
                  area,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
            
                Text(
                  "About:\n",
                  style: TextStyle(
                    fontSize: 20,
                    color:Colors.greenAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  about,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                // Second Title
                Text(
                  "Ingredient and Measures:\n",
                  style: TextStyle(
                    fontSize: 20,
                    color:Colors.greenAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  ingredient,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
            
                // Video Link Part
                // Text(
                //   "Link:$link",
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                const SizedBox(height: 8),
                // link != null
                //     ? Row(
                //   mainAxisSize: MainAxisSize.max,
                //   children: [
                //     Text("Video:"),
                //     GestureDetector(
                //       onTap: () async {
                //         await launchInBrowser(link ?? 'Ooops');
                //       },
                //       child: Text(
                //         link ?? "Ooops",
                //         maxLines: 1,
                //         style: const TextStyle(
                //           color: Colors.blue,
                //           decoration: TextDecoration.underline,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //       ),
                //     ),
                //   ],
                // )
                //     : Divider(),
              ],
            ),
          ),
        ),
      );
    },
  );
}




//AlertDialog(
//           title: const Text('Alert!'),
//           content: const Text('This is a simple alert dialog.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop(); // Dismiss the dialog
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );