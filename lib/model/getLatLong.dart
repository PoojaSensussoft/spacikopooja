class getLatLong {
  List<Offices> getlist;

  getLatLong({this.getlist});

  factory getLatLong.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['offices'] as List;
    print('MODEL::::${list.runtimeType}');
    List<Offices> dataList = list.map((i) => Offices.fromJson(i)).toList();

    return getLatLong(getlist: dataList);
  }
}

class Offices{
  String id;
  double lat;
  double lng;
  String name;
  String address;
  String image;
  String region;


  bool isClick = true;

  Offices({this.id, this.lat ,this.lng, this.name, this.address, this.image, this.region});

  factory Offices.fromJson(Map<String, dynamic> parsedJson){
    return Offices(id:parsedJson['id'], lat:parsedJson['lat'], lng:parsedJson['lng'],
        name:parsedJson['name'], address:parsedJson['address'], image:parsedJson['image'], region: parsedJson['region']);
  }
}