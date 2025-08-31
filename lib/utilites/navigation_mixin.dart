import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin NavigatorMixin<T extends StatefulWidget> on State<T> {
  void navigateTo(int index) {
    if (index == 0) {
      context.goNamed('home');
    } else if (index == 1) {
      context.goNamed('guide');
    } else if (index == 2) {
      context.goNamed('fav');
    } else if (index == 3) {
      context.goNamed("settings");
    }
  }
}
