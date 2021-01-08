import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/model/NotificationList.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';


class ListPagination extends StatefulWidget {
  @override
  _ListPaginationState createState() => _ListPaginationState();
}


class _ListPaginationState extends State<ListPagination> {
  ScrollController scrollController = new ScrollController();

  final dio = new Dio();
  int page = 1;
  List<Datum> _list = new List();


  Future<NotificationList> _getMoreData(int page) async {
    print('CALLED::::$page');
    final StringBuffer url = new StringBuffer("http://159.89.164.128:4200/notificationList");

    Dio dio = new Dio();
    var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAxLCJpYXQiOjE2MDk0MDg5MzEsImV4cCI6MTY0MDk0NDkzMX0.WYFJN02kGlwDazStiXDzXBgGan1xsMHO4ooEBKTbWR4';

    try {
      FormData formData = FormData.fromMap(
        {
          "user_id" : "Hy5W+98JqVh2m0NhBhC1zg==",
          "page": page.toString()
        },
      );

      dio.options.headers["x-access-token"] = token;
      var response = await dio.post(url.toString(), data: formData);

      if(response.data['status']){
        print('RESPONSE:::::${response.data['data']}');

        /*if response status is true*/
        List<dynamic> data = response.data['data'];

        setState(() {
          _list.addAll(data.map((i) => Datum.fromJson(i)).toList());
          print('LENGTH::::${_list.length}');
        });

      }else{
        Utility.showToast(response.data['message']);
      }

    } on DioError catch (e) {
      Utility.showToast(e.message);
      print('ERROR:::${e.message}');
    }
  }

  @override
  void initState() {
    super.initState();

    _getMoreData(page);

    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        page++;
        _getMoreData(page);
        print('IF:::::$page');
      }
    });
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  Widget _buildProgressIndicator() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: _buildList(),
      ),
    );
  }


  Widget _buildList(){
    return Container(
      child: _list.length!=0?

      ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text(_list[index].id, style: TextStyle(fontSize: 14, fontFamily: 'poppins_regular', color: spacikoColor.Colorblack)),
          );
        },
        controller: scrollController,
      )
      :  _buildProgressIndicator(),
    );
  }

}
