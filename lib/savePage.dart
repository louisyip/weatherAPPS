import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'savedCard.dart';
import 'package:http/http.dart';
import 'showWeather.dart';
import 'api.dart';
import 'dart:convert';
class SavePage extends StatefulWidget {
  SavePage({Key key}) : super(key: key);
  _SavePageState createState() => _SavePageState();
}
class _SavePageState extends State<SavePage> {
  List<String> dataList= [];
  _SavePageState();
  
  void getSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "saved";
    setState(() {
    dataList = prefs.getStringList(key) ?? "";
    });
    print(dataList);
    print(dataList.length);
  }
  void removeSavedData(int index) async{
    final prefs = await SharedPreferences.getInstance();
    final key = "saved";
    dataList.removeAt(index);
    prefs.setStringList(key, dataList);
  }
   void initState() {
     print("test");
    getSavedData();
   }
   void weatherSearch(String searchString) {
     searchString = 'q=' + searchString;
    ApiService.nameZipMethod(searchString, (Response response) {
      print("nameZipMethod");
      print(response.body);
      
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ShowWeatherPage(response:response)));
      
    }, (Error error) {
      print("Error");
    });
  }
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Dismissible(
          onDismissed: (direction) {
            removeSavedData(index);
            // remove item from list
          },
          background: Container(
            color: Colors.red,
          ),
          key: ObjectKey(index),
          child: SavedCard(
              data: dataList[index],
            )
            ),
            onTap: () {
              final responseJson = json.decode(dataList[index]);
              weatherSearch(responseJson['cityname']);
            },
          );
          
        },
      ),
    );
    }
}