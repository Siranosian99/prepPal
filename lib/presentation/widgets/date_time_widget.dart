// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:preppal/utilites/format_convertor/date_time.dart';
//
// class DateTimeWidget extends StatelessWidget {
//   DateAndTime _date_time = DateAndTime();
//   TextEditingController _dateController=TextEditingController();
//   void _showMyDialog(BuildContext context) {
//     DateAndTime _date_time = DateAndTime();
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Date Time Picker'),
//           content: Column(
//             children: [
//
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // close the dialog
//               },
//             ),
//             ElevatedButton(
//               child: const Text('Save'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // close the dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//    DateTimeWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(onPressed: (){
//       _date_time.displayTimePicker(context,_dateController);
//       _date_time.displayDatePicker(context,_dateController);
//       _showMyDialog(context);
//     }, icon: FaIcon(Icons.calendar_month_rounded));
//   }
// }
//
