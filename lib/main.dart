import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
void main() => asyncTask();

class MyApp extends StatefulWidget {
  List _data;
MyApp(this._data);

  @override
  LandingPage createState()  => new LandingPage(_data);
}

void asyncTask()  async{
  Map _data = await getJson();
List item = _data['products'];
  for(int i =0; i < item.length; i++){
print(item[i]['name']);
  }
  runApp(MyApp(item));
}


Future<Map> getJson() async {
  String apiUrl = 'http://142.93.241.14:3000/api/product?category=earrings';
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}

class LandingPage extends State<MyApp> {
List _data;
LandingPage(this._data);

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text('Json Parsing'),
        backgroundColor: Colors.cyan,
        ),
        body: new Container(
        child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, position) {

            return Ink(
              color: Colors.white,
             child: new Column(
               children: <Widget>[
                 Divider(height: 5.0,),
                 ListTile(
                   title: Text('${_data[position]['name']}'),
                   subtitle: Text('${_data[position]['tag']}'),
                   leading: Image.network('http://142.93.241.14:3000/'+ '${_data[position]['productFiles']}'
                     , height: 70.0, width: 70.0,),
                   contentPadding: EdgeInsets.all(5.0),
                 )

               ],
             ),

            );
          },
        ),
        ),

      ),
    );
  }

}