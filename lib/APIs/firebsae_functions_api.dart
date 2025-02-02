import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paysa/Models/notification_model.dart';

class FirebsaeFunctionsApi {
  static Future<Map<String, dynamic>> sendNotifications(
      List<NotificationModel> notifications) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://asia-south1-paysa-fd4b4.cloudfunctions.net/sendNotifications'));
    request.body = json.encode({
      "messages": notifications.map((e) => e.toJson()).toList(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody =
          jsonDecode(await response.stream.bytesToString());
      responseBody['isSuccess'] = true;
      return responseBody;
    } else {
      return {'isSuccess': false};
    }
  }
}
