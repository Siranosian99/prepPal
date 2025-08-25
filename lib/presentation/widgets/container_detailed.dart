import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preppal/utilites/format_convertor/date_time.dart';
import 'package:preppal/utilites/language_select.dart';
import 'package:preppal/utilites/url_open.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../consts/texts.dart';

class ContainerDetailed extends StatelessWidget with urlLunch {
  String? about;
  String? tags;
  String? country;
  String? ingredinet;
  String? link;
  VoidCallback? onTap;

  ContainerDetailed({
    super.key,
     this.about,
     this.tags,
     this.country,
     this.ingredinet,
     this.link,
    this.onTap
  });
  // String? selectedLang = "en"; // default value
  //
  // final List<Map<String, String>> languages = [
  //   {"code": "en", "name": "English"},
  //   {"code": "es", "name": "Spanish"},
  //   {"code": "fr", "name": "French"},
  //   {"code": "de", "name": "German"},
  //   {"code": "tr", "name": "Turkish"},
  // ];

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 2),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        width: double.infinity,
        height: 665,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Area:$country",
                style: TextStyle(
                  decoration: TextDecoration.overline,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              Text(
                tags ?? "Ooops",
                style: TextStyle(
                  decoration: TextDecoration.overline,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              Divider(),
              Text(
                textAlign: TextAlign.start,
                AppTexts.about,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.start,
                about ?? 'Ooops',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Divider(),
              Text(
                textAlign: TextAlign.start,
                AppTexts.ingredients,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.start,
                ingredinet ??'Ooops',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Divider(),
             Row(
               children: [
                 LanguageSelect(),
                 IconButton(onPressed: (){
                   // _date_time.displayTimePicker(context,_dateController );
                 }, icon: FaIcon(Icons.calendar_month))
               ],
             ),
              Divider(),
             link !=null ?Row(
               mainAxisSize: MainAxisSize.max,
               children: [
                 Text("Video:"),
                 GestureDetector(
                   onTap:()async{
                     await launchInBrowser(link ?? 'Ooops');
                   },
                   child: Text(
                     link ?? "Ooops",
                     maxLines: 2,
                     style: const TextStyle(
                         color: Colors.blue,
                         decoration: TextDecoration.underline,
                         overflow: TextOverflow.ellipsis
                     ),
                   ),
                 ),
               ],
             ):Divider()
            ],
          ),
        ),
      ),
    );
  }
}
