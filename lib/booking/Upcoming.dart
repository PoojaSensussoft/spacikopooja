import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:spacikopooja/model/ListData.dart';


class Upcoming extends StatefulWidget {
  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  Future<ListData>data_get;

  @override
  void initState() {
    super.initState();
    data_get = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Center(

      child: FutureBuilder<ListData>(
        future: data_get,
        builder: (context, snapshot){

          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(top: 10,left: 10, right: 10),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.data.length,
                itemBuilder: (context, index){
                  return Container(
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(child: Text("ID :  ${snapshot.data.data[index].id}"), padding: EdgeInsets.only(left: 10, top: 10)),
                          Container(child: Text("Name :  ${snapshot.data.data[index].name}"),padding: EdgeInsets.only(left: 10, top: 10)),
                          Container(child: Text("Email :  ${snapshot.data.data[index].email}"),padding: EdgeInsets.only(left: 10, top: 10,bottom: 10)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }


  Future<ListData> fetchAlbum() async {
    final response = await http.get("https://gorest.co.in/public-api/users");

    if (response.statusCode == 200) {
      return ListData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

}
