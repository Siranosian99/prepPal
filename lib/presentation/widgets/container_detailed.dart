import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:preppal/core/utils/language_select.dart';
import 'package:preppal/core/utils/url_open.dart';

import '../../consts/texts.dart';
import '../../core/utils/format_convertor/date_time.dart';
import '../../core/utils/notification.dart';
import '../../core/utils/translate.dart';
import '../../core/utils/translate_dialog.dart';

class ContainerDetailed extends StatefulWidget {
  String? name;
  String? about;
  String? tags;
  String? country;
  String? ingredinet;
  String? link;
  String? mealId;
  String? imgLink;
  String? mealName;
  final bool isLoading;
  final Function(bool) onLoadingChange;

  ContainerDetailed({
    super.key,
    this.about,
    this.name,
    this.tags,
    this.country,
    this.ingredinet,
    this.link,
    this.mealId,
    this.imgLink,
    this.mealName,
    required this.isLoading,
    required this.onLoadingChange,
  });

  @override
  State<ContainerDetailed> createState() => _ContainerDetailedState();
}

class _ContainerDetailedState extends State<ContainerDetailed> with urlLunch {
  final DateAndTime _date_time = DateAndTime();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  final noImg =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/2560px-No_image_3x4.svg.png';
  final box = Hive.box('language');

  @override
  void initState() {
    // clearLanguage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _timeController.dispose();
  }

  void clearLanguage() async {
    await box.clear();
  }

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
                "Area:${widget.country}",
                style: const TextStyle(
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
                widget.tags ?? "Ooops",
                style: const TextStyle(
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
              const Divider(),
              Text(
                textAlign: TextAlign.start,
                AppTexts.about,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                textAlign: TextAlign.start,
                widget.about ?? 'Ooops',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              const Divider(),
              Text(
                textAlign: TextAlign.start,
                AppTexts.ingredients,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                textAlign: TextAlign.start,
                widget.ingredinet ?? 'Ooops',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              const Divider(),
              const LanguageSelect(),
              SingleChildScrollView(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _date_time.displayDatePicker(context, _dateController);
                      },
                      icon: const FaIcon(FontAwesomeIcons.calendar),
                    ),
                    IconButton(
                      onPressed: () {
                        _date_time.displayTimePicker(context, _timeController);
                      },
                      icon: const FaIcon(FontAwesomeIcons.timeline),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        await NotificationMethod.scheduleNotificationFromInput(
                          1,
                          _date_time.selectedDate,
                          _date_time.selectedTime,
                          widget.name ?? "MealName",
                          widget.mealId ?? '',
                          widget.imgLink ?? noImg,
                          widget.mealName ?? "MealName",
                        );
                      },
                      child: const Text("Set Timer"),
                    ),
                    const SizedBox(width: 10),

                    ElevatedButton(
                      onPressed:widget.isLoading? null: () async {
                        widget.onLoadingChange(true);
                        final lang = box.get('language');
                        final translatedAbout = await translateData(
                          widget.about ?? '',
                          lang,
                        );
                        final translatedCountry = await translateData(
                          widget.country ?? '',
                          lang,
                        );
                        final translatedIngredinet = await translateData(
                          widget.ingredinet ?? '',
                          lang,
                        );
                        final t1 = await translateData('About:', lang ?? 'en');
                        final t2 = await translateData(
                          'Ingredient and Measures:',
                          lang ?? 'en',
                        );
                        final t3 = await translateData('Area:', lang ?? 'en');
                        final t4 = await translateData(
                          'Meal Name:',
                          lang ?? 'en',
                        );
                        if (!context.mounted) return;
                        translateDialog(
                          context,
                          t1,
                          t2,
                          t3,
                          t4,
                          widget.mealName ?? "No Meal",
                          widget.imgLink ?? noImg,
                          translatedAbout,
                          translatedCountry,
                          translatedIngredinet,
                          widget.link ?? '',
                        );
                        widget.onLoadingChange(false);
                      },
                      child: Text(
                        widget.isLoading ? "Loading..." : "Translate",
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              widget.link != null
                  ? Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text("Video:"),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await launchInBrowser(widget.link ?? 'Ooops');
                          },
                          child: Text(
                            widget.link ?? "Ooops",
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  : const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
