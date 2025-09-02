import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/utilites/format_convertor/date_time.dart';
import 'package:preppal/utilites/language_select.dart';
import 'package:preppal/utilites/url_open.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../consts/texts.dart';
import '../../utilites/notification.dart';
import '../../utilites/translate.dart';
import '../../utilites/translate_dialog.dart';

class ContainerDetailed extends StatelessWidget with urlLunch {
  String? name;
  String? about;
  String? tags;
  String? country;
  String? ingredinet;
  String? link;
  VoidCallback? onTap;
  String? mealId;
  String? imgLink;
  String? mealName;

  ContainerDetailed({
    super.key,
    this.about,
    this.name,
    this.tags,
    this.country,
    this.ingredinet,
    this.link,
    this.mealId,
    this.onTap,
    this.imgLink,
    this.mealName,
  });

  final DateAndTime _date_time = DateAndTime();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final noImg='https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/2560px-No_image_3x4.svg.png';

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
                ingredinet ?? 'Ooops',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Divider(),
              LanguageSelect(),
              SingleChildScrollView(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _date_time.displayDatePicker(context, _dateController);
                      },
                      icon: FaIcon(Icons.calendar_month),
                    ),
                    IconButton(
                      onPressed: () {
                        _date_time.displayTimePicker(context, _timeController);
                      },
                      icon: FaIcon(Icons.timer),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        await NotificationMethod.scheduleNotificationFromInput(
                            1,
                            _date_time.selectedDate,
                            _date_time.selectedTime,
                            name ?? "MealName",
                            mealId ??'',
                            imgLink?? noImg,
                            mealName ?? "MealName"
                        );
                      },
                      child: const Text("Set Timer"),
                    ),
                    SizedBox(width: 10,),

                    ElevatedButton(
                      onPressed: ()  async{
                        final translatedAbout= await translateData(about?? '','hy');
                        final translatedCountry=await translateData(country?? '','ar');
                        final translatedIngredinet=await translateData(ingredinet?? '','ar');

                       translateDialog(context,translatedAbout,translatedCountry,translatedIngredinet,link ??'',);
                      },
                      child: const Text("Translate"),
                    ),
                  ],
                ),
              ),
              Divider(),
              link != null
                  ? Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Video:"),
                      GestureDetector(
                        onTap: () async {
                          await launchInBrowser(link ?? 'Ooops');
                        },
                        child: Text(
                          link ?? "Ooops",
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  )
                  : Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
