import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:preppal/utilites/url_open.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../consts/texts.dart';

class ContainerDetailed extends StatelessWidget with urlLunch {
  String? about;
  String? tags;
  String? country;
  String? ingredinet;
  String? link;

  ContainerDetailed({
    super.key,
     this.about,
     this.tags,
     this.country,
     this.ingredinet,
     this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
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
              Divider(color: Colors.black),
              ElevatedButton(
                onPressed: () {
                  // Add your logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // background color
                  foregroundColor: Colors.white, // text color
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add to Favourite',
                  style: TextStyle(fontSize: 16),
                ),
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
                     maxLines: 1,
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
