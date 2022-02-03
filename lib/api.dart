import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ApiService {
  String apiKey = "95d190a434083879a6398aafd54d9e73";
  
  static void nameZipMethod(String searchString, void onSuccess(Response response), void onFailed(Error error)) async {
    final ioClient = HttpClient();
    ioClient.connectionTimeout = const Duration(seconds: 20);
    final client = http.IOClient(ioClient);
    http.Response response;
    try {
      response = await client.get("http://api.openweathermap.org/data/2.5/weather?"+searchString+"&appid=95d190a434083879a6398aafd54d9e73",
          headers: {'Content-Type': 'application/json'});
      if (response != null) {
        onSuccess(response);
      } else {
        onFailed(Error());
      }
    } on SocketException catch (e) {
      // Display an alert, no internet
    } catch (err) {
      print(err);
      return null;
    }

    ioClient.close();
   
  }

}
