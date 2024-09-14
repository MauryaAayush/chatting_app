import 'dart:convert';
import 'dart:developer';

import 'package:googleapis_auth/auth_io.dart';

class GetServerToken {
  GetServerToken._();
  static final GetServerToken instance = GetServerToken._();


  Future<String> getAccessToken() async {
    // Load the service account credentials from the JSON file
    var accountCredentials = ServiceAccountCredentials.fromJson(privateKey);

    // Define the scopes required for FCM (Cloud Platform scope)
    var scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    // Use the credentials to get an authenticated client
    var authClient = await clientViaServiceAccount(accountCredentials, scopes);

    // Return the OAuth 2.0 access token
    return authClient.credentials.accessToken.data;
  }

  // This server token update every hour as per internet info..
  Future<String?> getServerToken() async {
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final json = jsonEncode(privateKey);
    final clientCredentials = ServiceAccountCredentials.fromJson(json);
    final client = await clientViaServiceAccount(clientCredentials, scopes);
    try {
      final serverToken = client.credentials.accessToken.data;
      log("Server token: \n\n$serverToken  \n\n|");
      return serverToken;
    } catch (e) {
      log("Server token error: $e");
      return null;
    }
  }
}

////////////////////////
final privateKey = {
  "type": "service_account",
  "project_id": "chatting-app-6db63",
  "private_key_id": "67d219b35cb27d476b69aeec27399946e913d8d4",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCdHblNP9S9rFc1\nvN8SUYDpCMkO97Oy3RHVRnJ9Y4L9kWSn4mI/swcjSRP49NyEXB+df9jAMVj7yADT\nLsefDIQUPdkA4UNtXSDs/hZEy797XSOiHkLR0SE7Z9WfAHywAn8A1FgdvbveBPC2\nc1G7IHftyrC6mONAeZm4t44YZq1s+uouBWi9AXe39f5M9DXLE6izdeOwOCmK32Dt\n+41NCSiplGwmOd15RBwI9xJLQ6KeGO5Iyb8JBKSKKXC99BosoHwqwgbqpIK/ZZZV\nOvQ/WtpAlZyg0mx37Sa50rHKUiik7t5t3d8rmck7UAdf01j5Pk1RUJOlDaKp+oSm\nzn57TxknAgMBAAECggEAC3BkEuNAVnTrPo7bQOatN4o7tTrEmxOsXjZMVKO/oD2L\nMgvx8khTDzcdXKVbPsnERX/O5KNTIrW7laSUxRgwr5aXK5C7C4XZxVd0gJrC/LTZ\nyM5iOAt9W2libLqo2Vm9LG7JYZT0TiRW8DmyLCkfgjEdL+C8vu97iS7YCh/Dpaj7\nx4G1j7kQwZbv5KNk6kf85sOxqoc5rC9VXEbwyqz0i2dp18hd5k61oUD6Di73bXC5\ngRxZIx5x0vgktnaRKZHtvor+uULZV+qmaSdSt5f6/iV1jFVVwWfrLIENbdAILvnM\n0FhbrWKlSbkt/RWcW0a2tYXyH/1zbgL9LVC7hy8WpQKBgQDXdCdu/eW2Xfe1jMIY\nAjtNMZMWje5Yz+k5hhcMFceGVphXqsBnC8vSoSNe1ZMzIVsBnP5Odg2q94C2lfZK\nVaRlKNPykP8sbzx7Mp1RCGHlG8HYxGWIUe+BmFptWM/NTcfq2FZtyawKXwEOmGOl\nQmpB+gtKcniCLM+uBklTNCiF0wKBgQC6rw6Nv7f2wPDfRGDsvMB4+b04zSYLq/cr\nvuZaH8wZCVmHQpC83Pq+ow2MSQXX5hslytcYgZqdwJY7/PKXhldO3FWBi3wL4jpr\nAbAS7CTyj8/IzuJwD0KHoFgpCNYialVmBArxRoyE3rKeakO164K8U2Y/P6SHgKi4\n8PMAvIjm3QKBgQCNqK9syL9KgsolsmDDjGQVQy0kvTkjZ8A+tC1fIsrHRxRvP7O1\njQn8eTpaVi6shZfinaiPSgt+h7E3W65N/bVTVd7VNASy4IhxsDvDVbGYBAIWVjsz\nwDurh9Kc5rHqmOODQ67ADMNzJjf5srSBqgNXUeIulskpPfFmyHdZn4etRQKBgQCm\nlDRJWeyemzWUFCDkvdyFVlt5Rt2PBqiseVB01PC62nPv1P7v98MqvrYFGtfC+cn5\npBDhBizgXQvxhVk2yiI39TW7Paq3s+tqtnvVtq+VXawMREcbtRIpkXN5UjA5T2ba\ne/sDpm8W1NzPrIS03OywfT68a161pqFnPWGoo5MJZQKBgQDG/zMd6sZRozPo6B4x\nqhPMV0aNY+J1E+i4T1Z5ymFunNqBlj6HR3MTw4dVpN4UmLCuuDUDh9B0WB5UBswX\n4tqWmRlc3lpXhYKvV30bwnG/Yl8bDUM6BEXkZphOH8ng8VMzJ4agnadwh+5rNZTp\nYffIQ3pYtDz4SBeQdxDXfMYGUg==\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-8ys3b@chatting-app-6db63.iam.gserviceaccount.com",
  "client_id": "118320847362477669981",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-8ys3b%40chatting-app-6db63.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
};

