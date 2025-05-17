import 'package:event_radar2/feature/authentication/data/data_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry_point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterNotificationsInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _requestPermission();

    await _setupMessageHandlers();

    // Retrieve the FCM token
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    UserStatus.deviceToken = token;
    print('Device Token: $token');
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    print("Permission Status : ${settings.authorizationStatus}");
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterNotificationsInitialized) {
      return;
    }

    //android setup
    const channel = AndroidNotificationChannel(
        'high_importance_channel', 'High Importance Notifications',
        description: 'This channel is used for important notifications',
        importance: Importance.high);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //ios setup
    final initializationSettingsDarwin = DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    //flutter notification setup
    await _localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {});

    _isFlutterNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  'high_importance_channel', 'High Importance Notifications',
                  channelDescription:
                      'This channel is used for important notifications',
                  importance: Importance.high,
                  priority: Priority.high,
                  icon: '@mipmap/ic_launcher'),
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              )),
          payload: message.data.toString());
    }
  }

  Future<void> _setupMessageHandlers() async {
    print("Setting up message handlers");

    // Foreground message handler
    FirebaseMessaging.onMessage.listen((message) {
      print("Foreground message received: ${message.toString()}");
      showNotification(message);
      // _handleBackgroundMessage(message);
    });

    // Background message handler
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("App opened from background notification: ${message.toString()}");
      _handleBackgroundMessage(message);
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print(
            "App launched from terminated state with notification: ${message.toString()}");
        _handleBackgroundMessage(message);
      }
    });
  }

  void _handleInitialMessage(RemoteMessage message) {
    // Handle navigation or actions for initial message
    print("Handle initial message: ${message.notification?.title}");
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    print("Handling background message: ${message.toString()}");
    print("data type: ${message.data['type']}");
    // if (message.data['type'] == 'sales') {
    //   print("Sales notification received");
    //   print("navigatorKey: " + navigatorKey.currentState.toString());
    //   navigatorKey.currentState?.push(MaterialPageRoute(
    //     builder: (context) => BlocProvider(
    //       create: (context) => CampaignCubit(),
    //       child: CampaignScreen(id: int.parse(message.data['reference_id'])),
    //     ),
    //   ));
    // } else if (message.data['type'] == 'service') {
    //   print("Service notification received");
    //   navigatorKey.currentState?.push(MaterialPageRoute(
    //     builder: (context) => BlocProvider(
    //       create: (context) => ServiceDetailCubit(),
    //       child: OngoingServiceDetail(serviceId: int.parse(message.data['reference_id'])),
    //     ),
    //   ));
    // } else {
    //   print("Unknown notification type: ${message.data['type']}");
    // }
  }
}
