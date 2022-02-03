import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'api.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'showWeather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/saveCity.Dart';
class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  _MainPageState createState() => _MainPageState();
}

final TextEditingController nameZipController = new TextEditingController();

class _MainPageState extends State<MainPage> {
  _MainPageState();
  void _showDialog($title, $content) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        if (Platform.isAndroid) {
          return AlertDialog(
            title: new Text($title),
            content: new Text($content),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("關閉"),
                onPressed: () {
                  Navigator.of(context).pop();
                  if ($title == "Success") {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        } else {
          return CupertinoAlertDialog(
            title: new Text($title),
            content: new Text($content),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context, 'Discard');
                    if ($title == "Success") {
                      Navigator.pop(context);
                    }
                  }),
            ],
          );
        }
      },
    );
  }

  bool isNumeric(String string) {
    if (string == null || string.isEmpty) {
      return false;
    }

    final number = num.tryParse(string);

    if (number == null) {
      return false;
    }

    return true;
  }

  void nameZipSearch() {
    if (isNumeric(nameZipController.text)) {
      String searchString = 'zip=' + nameZipController.text;
      weatherSearch(searchString);
    } else {
      String searchString = 'q=' + nameZipController.text;
      weatherSearch(searchString);
    }
  }

  double userlatitude = 0;
  double userlongitude = 0;
  void gpsSearch() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userlatitude = position.latitude;
      userlongitude = position.longitude;
      String searchString =
          'lat=' + position.latitude.toString() + '&lon=' + position.longitude.toString();
      weatherSearch(searchString);
    });
  }
  void savedData(dynamic responseJson) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "saved";
    List<String> dataString = prefs.getStringList(key) ?? [];
    if(dataString.contains(json.encode(SaveCity(
        id: responseJson['id'].toString(),
        title: responseJson['name'],
        cityname :responseJson['name']
      ).toJson()))){
    }else{
      List<String> dataList = [];
      if(dataString.length != 0){
      dataList = dataString;
      }
      dataList.add(json.encode(SaveCity(
        id: responseJson['id'].toString(),
        title: responseJson['name'],
        cityname :responseJson['name']
      ).toJson()));
      
      prefs.setStringList(key, dataList);
    }
  }
  void weatherSearch(String searchString) {
    ApiService.nameZipMethod(searchString, (Response response) {
      final responseJson = json.decode(response.body);
      if (responseJson['cod'] == '400') {
        _showDialog("Warning", "Please enter city name or zip code.");
      } else if (responseJson['cod'] == '404') {
        _showDialog("Warning", "city name or zip code wrong!");
      } else  {
        savedData(responseJson);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ShowWeatherPage(response:response)));
      }
    }, (Error error) {
      print("Error");
    });
  }

  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Column(children: <Widget>[
        TextFormField(
            controller: nameZipController,
            decoration: InputDecoration(
              hintText: "Please Enter city name or zip code",
              contentPadding: EdgeInsets.all(0),
            )),
        Container(
            width: MediaQuery.of(context).size.width - 60,
            margin: EdgeInsets.fromLTRB(30, 0, 30, 20),
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
            ),
            child: FlatButton(
              color: Colors.green[300],
              onPressed: () {
                nameZipSearch();
              },
              child: Text(
                "Check weather",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            )),
        Container(
            width: MediaQuery.of(context).size.width - 60,
            margin: EdgeInsets.fromLTRB(30, 0, 30, 20),
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
            ),
            child: FlatButton(
              color: Colors.green[300],
              onPressed: () {
                gpsSearch();
              },
              child: Text(
                "Current location weather",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            )),
      ]),
    );
  }
}
