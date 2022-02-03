import 'package:flutter/material.dart';
import 'dart:convert';
import 'model/saveCity.Dart';
class SavedCard extends StatelessWidget {
  final String data;
  SavedCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);
    final responseJson = json.decode(data);
    return Container(
      //color: Colors.green,
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(responseJson['title']),
          
        ],
      ),
    );
  }
}
