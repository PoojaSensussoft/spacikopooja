import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class DemoPagination extends StatefulWidget {
  @override
  _DemoPaginationState createState() => _DemoPaginationState();
}

class _DemoPaginationState extends State<DemoPagination> {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apiUrl = "https://jsonplaceholder.typicode.com/albums/1/photos";
  int pageNo = 1;
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  List albums = List();

  void _fetchData() async {
    if (!isLoading) {
      setState(() { isLoading = true; });
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        List albumList = List();
        var resultBody;
        pageNo = (pageNo > 100) ? 1 : pageNo++;
        apiUrl = "https://jsonplaceholder.typicode.com/albums/$pageNo/photos";
        resultBody = jsonDecode(response.body);

        for (int i = 0; i < resultBody.length; i++) {
          albumList.add(resultBody[i]);
        }
        setState(() {
          isLoading = false;
          albums.addAll(albumList);
        });

      } else {
        setState(() { isLoading = false; });
      }
    }
  }

  @override
  void initState() {
    this._fetchData();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return albums.length < 1
        ? Center(
      child: Container(
        child: Text(
          'No data',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    )
        : ListView.builder(
      itemCount: albums.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == albums.length) {
          return _buildProgressIndicator();
        } else {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                  NetworkImage(albums[index]['thumbnailUrl']),
                ),
                title: Text((albums[index]['title'])),
                onTap: () {
                  print(albums[index]);
                },
              ),
            ),
          );
        }
      },
      controller: _scrollController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
      ),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
