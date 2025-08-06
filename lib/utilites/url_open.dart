import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

mixin urlLunch on StatelessWidget{

Future<void> launchInBrowser(String urlString) async {
  final Uri _url = Uri.parse(urlString);
  if (!await launchUrl(
    _url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $_url');
  }
}}