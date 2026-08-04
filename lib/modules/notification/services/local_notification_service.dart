import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel =
  AndroidNotificationChannel(
    'global_channel', // MUST MATCH
    'Global Notifications',
    description: 'All app notifications',
    importance: Importance.high,
  );

  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(initSettings);

    // 🔥 CREATE CHANNEL (IMPORTANT)
    await _plugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  static Future<void> show({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      _channel.id,        // ✅ SAME ID
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.high,
      priority: Priority.high,
    );

    final details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload?.toString(),
    );
  }
}
