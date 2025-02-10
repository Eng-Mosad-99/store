import 'dart:developer';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class HelperFunctions {
  static Future<void> launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
        );
      }
    } catch (e) {
      log('Error launching URL: $e');
    }
  }

  static void openWhatsApp({
    required String phoneNumber,
    required String message,
  }) async {
    Uri whatsappUrl = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");
    // Check if the URL can be launched
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(
        whatsappUrl,
        mode: Platform.isIOS
            ? LaunchMode.platformDefault
            : LaunchMode.externalNonBrowserApplication,
      );
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  static openCall({required String phoneNumber}) async {
    var link = Uri.parse('tel: ${'+$phoneNumber'}');
    if (await canLaunchUrl(link)) {
      launchUrl(
        link,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
