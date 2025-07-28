import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:utilidades/src/views/notification_detail.dart';

class FirebaseCloudMessaging extends StatefulWidget {
  const FirebaseCloudMessaging({super.key});

  @override
  State<FirebaseCloudMessaging> createState() => _FirebaseCloudMessagingState();
}

class _FirebaseCloudMessagingState extends State<FirebaseCloudMessaging> {
  // Notificação PUSH
  void firebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Pedindo Permissão do Usuário
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Segmentação de envio
    await FirebaseMessaging.instance.subscribeToTopic("motorista");

    // Token FCM
    String? tokenFCM = await messaging.getToken();
    print("Token FCM: $tokenFCM");

    // Notificação com o App Aberto
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? "";
      final body = message.notification?.body ?? "";

      if (!mounted) return;

      // Exibir a Mensagem
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(
            body,
            maxLines: 1,
            style: TextStyle(overflow: TextOverflow.ellipsis),
          ),
          actions: [
            TextButton(onPressed: () {}, child: Text("Ver Detalhes")),
            TextButton(onPressed: () {}, child: Text("Fechar")),
          ],
        ),
      );
    });

    // Notificação com app em background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final title = message.notification?.title ?? "";
      final body = message.notification?.body ?? "";

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationDetail(title: title, body: body),
        ),
      );
    });

    // Notificação com app fechado
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        final title = message.notification?.title ?? "";
        final body = message.notification?.body ?? "";

        if (!mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationDetail(title: title, body: body),
          ),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    firebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Center(child: Text("Utilizando Firebase Cloud Messaging")),
    );
  }
}
