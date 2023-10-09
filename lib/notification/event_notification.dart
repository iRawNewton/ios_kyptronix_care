import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> sendCustomNotificationToUser(
    context, String title, String content, String id) async {
  // create a notification with the given player ID as the target
  var notification = OSCreateNotification(
    playerIds: [id],
    content: content, // content
    heading: title, // title
    androidSound: 'iphone_sound',
    androidChannelId: '38aa8271-8a48-4936-8ca6-a6f1d0b674f9',
    additionalData: {'category': 'KyptronixDemo'},
  );
  await OneSignal.shared.postNotification(notification);
}
