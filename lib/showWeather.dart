import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


class ShowWeatherPage extends StatefulWidget {
  final Response response;
  ShowWeatherPage({Key key, this.response}) : super(key: key);
  _ShowWeatherPageState createState() => _ShowWeatherPageState(this.response);
}
class _ShowWeatherPageState extends State<ShowWeatherPage> {
  Response response;
  
  _ShowWeatherPageState(this.response);
  Widget build(BuildContext context) {
    final responseJson = json.decode(response.body);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(responseJson['name']),
      ),
      body:Container(
      height: double.infinity,
                    child: Padding(
                              padding: EdgeInsets.all(10),
                              child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FadeInImage.assetNetwork(
                height: 200,
                            width: MediaQuery.of(context).size.width ,
                            fit: BoxFit.fitWidth,
                            placeholder: 'assets/images/loading.gif',
                            image:"http://openweathermap.org/img/wn/"+responseJson['weather'][0]['icon']+"@4x.png",
                          ),
             Text("Weather description : "+responseJson['weather'][0]['description'])
            ],
          ),
        ),
      )
      ),
    );
      
    
    }
}