import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'get_server_token.dart';

class ApiServices {
  ApiServices._();

  static final ApiServices apiServices = ApiServices._();

  static const String baseUrl =
      "https://fcm.googleapis.com/v1/projects/chatting-app-6db63/messages:send";
  static String serverKey = generatedToken;
  static const String senderId = "";

  Future<void> pushNotification({required String title, body, token}) async {

    String AccessToken = await GetServerToken.instance.getAccessToken();

    Map payLoad = {
      "message": {
        "token": token,
        "notification": {"title": title, "body": body},
        "data": {"response": "Message Done !"}
      }
    };
    String dataNotification = jsonEncode(payLoad);
    var response = await http.post(
      Uri.parse(baseUrl),


      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $AccessToken',
      },
      body: dataNotification,
    );
    if (response.statusCode == 200) {
      print('Successfully sent message: ${response.body}');
    } else {
      print('Error sending message: ${response.body}');
    }
    log(response.body);
  }
}

String generatedToken =
    "ya29.c.c0ASRK0GaS0gLAc8TDjURdJAtJYjvW9JES-Yub343kqjhfPI9LFQaCWfMuD5RHZMC8Aw1QtMEVd0rVjQ1_7gSv9Rga5mH1wV6Xk-8M7eyeU_U6Sel_iAui02NSmSKgl4jzd-DkKP9Mno_vNoNcQsUiVjaMIIIFCZicRO-tm9lYNYG0hmBswh8gvGzGtj7OhyzCxB3wET0OgLTnhF8_RQRxygOObcRATn8baEys589EKClOZsmAW4-BF9J1BV76qiSqTnCF8ClvdtFXpdTSdqS-gqrPY7YMVy1uuHvkcInMhIttd-RpPNhyh88EGFEFhibxZfT8pp920BqRWEnw6x1eXJ1AVEt5MU_X4y-NUC3RQW-oXpuR9WHGDUK5L385P-ea7mmjnser7uZMjrkwRf6V6XQbWF4xmcX6U77OIFjOx-RMnX5tg7vOtQXWyryV82bcqjJyyp70paxmefxaOa164v4s76-Fx4uJYBdkUUzQ3p62X14cit8y6Jdo3M1V8r4UeXFZaFgZZppgv1R-a63rrlBBey0rcifUbOi4iYe9drd9SVjVfyXzV9ht35mjhOYly9e9ffSc9Us4yngewh0BrfJZ3ROo4u1qBwIz3cUgr-hbf--tZ6Igb_q3MqjgmuVwc-fnw0Z8uzd_99wacOduMrvBXwfpYIb8o7kp0a72BcweohygOdW_i2wzlypoaYxuw2yOMjSm2j59I47X-BWUc9iVrWbj_BJzIhwsrB_yO5bFrJi27_iyJ-RiUhsh6XlFpR7de-YZsWd6SfMRukynX4jSjxZkFu4pa3U2M6_hbJdelOkVSUvqFIjlw3uRbOxeBe--yyOlRpi0xB-lM6iUvY0vOp8u_JYtsY--Vmw3r1t3q94S27i9qfgi6wk6Z3VUJoilOxOxibgSnx46vzZ69c02gpbMh2pcuir8h6i6dZJ74yeZu0w5dQl9gzf0ScOxvfboROS0-OM6aJeYY7MWcj1M4pqzWiUV3dlYzg5JSpf8SUpOjn-OWyW";
