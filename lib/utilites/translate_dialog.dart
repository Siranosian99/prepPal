import 'package:flutter/material.dart';

void translateDialog(BuildContext context) {
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(21),
          ),
          width: 300,
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Title
              Text(
                "Area",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 12),

              // Second Title
              Text(
                "Ingredient and Measures",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Video Link Part
              Text(
                "Video Link",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "https://youtube.com/...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
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