import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  /// Launches the specified URL based on the type of action
  static Future<void> launchURL({
    required String actionType,
    required String value,
    double? latitude, // Latitude for Google Maps
    double? longitude, // Longitude for Google Maps
  }) async {
    final packageInfo = await PackageInfo.fromPlatform();
    String url;

    switch (actionType.toLowerCase()) {
      case 'google_maps':
        if (latitude != null && longitude != null) {
          // Open Google Maps with latitude and longitude
          url =
              'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
        } else {
          throw Exception(
              'Latitude and Longitude are required for Google Maps');
        }
        break;
      case 'call':
        // Opens the phone dialer with the specified number
        url = 'tel:$value';
        break;
      case 'whatsapp':
        // Opens WhatsApp with a specified number or message
        url =
            'https://wa.me/$value'; // Ensure the value is a valid number, e.g., 628123456789
        break;
      case 'sms':
        // Opens the SMS app with the specified number
        url = 'sms:$value';
        break;
      case 'email':
        // Opens the email app with the specified email address
        url = 'mailto:$value';
        break;
      case 'browser':
        // Opens a generic web URL
        url = value;
        break;
      case 'update_app':
        // Opens Play Store or App Store based on the platform
        if (value.toLowerCase() == 'android') {
          url =
              'https://play.google.com/store/apps/details?id=${packageInfo.packageName}';
        } else if (value.toLowerCase() == 'ios') {
          url = 'https://apps.apple.com/app/id${packageInfo.packageName}';
        } else {
          throw Exception('Invalid platform type for update_app: $value');
        }
        break;
      default:
        throw Exception('Invalid action type: $actionType');
    }

    await launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault);
  }
}
