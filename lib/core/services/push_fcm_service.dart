import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class PushFcmService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson =
        await rootBundle.loadString('assets/json/fcm-dev-coinku.json');

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    //get fcm access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    client.close();
    return credentials.accessToken.data;
  }

  static sendNotificationToFCM(
    BuildContext context, {
    // required String deviceToken,
    required String body,
    Map<String, dynamic>? dataNotification,
  }) async {
    final String fcmAccessToken = await getAccessToken();
    String endpointFCM =
        "https://fcm.googleapis.com/v1/projects/dev-coinku/messages:send";

    final Map<String, dynamic> message = {
      'message': {
        'topic': 'coinku',
        'notification': {
          'title': 'Mobile Coinku',
          'body': body,
        },
        'android': {
          'notification': {
            'icon': 'notification_icon',
          },
        },
        'data': dataNotification ?? {},
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFCM),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $fcmAccessToken',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      log('FCM Notification sent successfully');
    } else {
      log('Failed to send notification, ${response.statusCode}');
    }
  }
}
