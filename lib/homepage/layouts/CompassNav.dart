import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spacikopooja/model/getLatLong.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class CompassNav extends StatefulWidget {
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<CompassNav> {
  bool isVisible = false;
  bool isScrollVisible = false;
  int isSelectedPos;

  /*first Time*/
  List<Choice> _list = <Choice>[
    Choice(title: 'Hourly',),
    Choice(title: 'Daily',),
    Choice(title: 'Monthly',),
    Choice(title: 'Property Type',),
  ];

  /*dialog propery list*/
  List<SelectProperty> _propertyList = <SelectProperty>[
    SelectProperty(propertyName: 'Meeting Room',),
    SelectProperty(propertyName: 'Open Space',),
    SelectProperty(propertyName: 'Private Desk Area',),
    SelectProperty(propertyName: 'Private Room',),
    SelectProperty(propertyName: 'Shared Desk Area',),
    SelectProperty(propertyName: 'Shared Room',),
  ];

  /*google map*/
  Set<Marker> _markers = {};
  LatLng _lng;
  Position _currentPosition;
  CameraPosition cameraPosition;
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor pinLocationIcon1;

  /*multiple marker*/
  Completer _controller = Completer();
  List<Offices> list;
  int tappedIndex;

  int _index = 0;
  double size;
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    /*unSeleced pos*/
    isSelectedPos = -1;

    /*get latlong list*/
    list = getLatLng();

    /*google map*/
    setCustomMapPin();
    setCustomMapPin1();
    _getCurrentLocation();

    tappedIndex = -1;

    _pageController = new PageController(initialPage: 0,viewportFraction: 0.75, keepPage: true);
  }

  List<Offices> getLatLng() {
    String listData = '{"offices": [{"address": "Aabogade 15 8200 Aarhus Denmark","id": "aarhus","image": "https://lh3.googleusercontent.com/tpBMFN5os8K-qXIHiAX5SZEmN5fCzIGrj9FdJtbZPUkC91ookSoY520NYn7fK5yqmh1L1m3F2SJA58v6Qps3JusdrxoFSwk6Ajv2K88","lat": 56.172249,"lng": 10.187372,"name": "Aarhus","phone": "","region": "europe"},{"address": "Claude Debussylaan 34 1082 MD, Amsterdam Netherlands","id": "amsterdam","image": "https://lh3.googleusercontent.com/gG1zKXcSmRyYWHwUn2Z0MITpdqwb52RAEp3uthG2J5Xl-4_Wz7_WmoM6T_TBg6Ut3L1eF-8XENO10sxVIFdQHilj8iRG29wROpSoug","lat": 52.337801,"lng": 4.872066,"name": "Amsterdam","phone": "","region": "europe"},{"address": "2300 Traverwood Dr. Ann Arbor, MI 48105 United States","id": "ann-arbor","image": "https://lh3.googleusercontent.com/Iim0OVcAgg9vmXc5ADn9KvOQFplrMZ8hBTg2biiTtuWPy_r56cy4Byx1ROk6coGt7knQdmx_jO45VX1kiCJZ0QzEtS97AP_BYG4F2w","lat": 42.3063848,"lng": -83.7140833,"name": "Ann Arbor","phone": "+1 734-332-6500","region": "north-america"},{"address": "Fragkokklisias 7 Athens 151 25 Greece","id": "athens","image": "https://lh3.googleusercontent.com/XroZnqewSrO6KuvXM5hDHtjUJzUcRQLZYfCKs4jP44dKezRvNx58uxaqUKS4fQ2eXzG2TpJNJ1X2xtfBe7Prl5hSG_xjPEF1xLtFodM","lat": 38.03902,"lng": 23.804595,"name": "Athens","phone": "","region": "europe"},{"address": "10 10th Street NE Atlanta, GA 30309 United States","id": "atlanta","image": "https://lh3.googleusercontent.com/py7Qvqqoec1MB0dMKnGWn7ju9wET_dIneTb24U-ri8XAsECJnOaBoNmvfa51PIaC0rlsyQvQXvAK8RdLqpkhpkRSzmhNKqb-tY2_","lat": 33.781827,"lng": -84.387301,"name": "Atlanta","phone": "+1 404-487-9000","region": "north-america"},{"address": "500 W 2nd St Suite 2900 Austin, TX 78701 United States","id": "austin","image": "https://lh3.googleusercontent.com/WFaJgWPdd7xPL7CQHizlqEzLDjT_GUAiWHIWUM0PiVSsv8q3Rjt9QgbyQazuQwYfN5qLORajv8eKSHlKwZo-M89T2Y12zFSxSIme08c","lat": 30.266035,"lng": -97.749237,"name": "Austin","phone": "+1 512-343-5283","region": "north-america"},{"address": "No. 3, RMZ Infinity \u2013 Tower E Old Madras Road 4th and 5th Floors Bangalore, 560 016, India","id": "bangalore","image": "https://lh3.googleusercontent.com/YDyQevoY-D0eZQ9sYHp8dQjpFF5JpLfLK-0OM-uJK1oNK3_LRnGJAM0uXi9qb9UigKnVIIXlIgidxhRlnaB_FPtUOqPzrsCSiFZyoQ","lat": 12.99332,"lng": 77.660176,"name": "Bangalore","phone": "+91-80-67218000","region": "asia-pacific"},{"address": "57 Park Ventures Ecoplex 14th Floor, Wireless Road Bangkok, 10330, Thailand","id": "bangkok","image": "https://lh3.googleusercontent.com/nh9uOUPj6iWjKZSHIrnkfGhIWGBb8thguRM5_ehCOkyF-qfwzYciDJFVRSvQ6QxlSA6eZUMkzgdW9zR0Gab2ZZPg8NlB7V_V3wB5","lat": 13.742866,"lng": 100.547983,"name": "Bangkok","phone": "","region": "asia-pacific"},{"address": "6th Floor, Tower B, Raycom InfoTech Park No. 2 Kexueyuan South Road Zhongguancun Beijing 100190","id": "beijing","image": "https://lh3.googleusercontent.com/v_tD3VvC8-dnhqSF9xhj5Hx7F_bb3-wieM19i-Ho2C3by6mt7-JpPc7KsYVHUZFqQl5ON3adVEV1N4OlzSvHLrr3sr4GtXErDbGC","lat": 39.9848878,"lng": 116.3265708,"name": "Beijing","phone": "+86-10-62503000","region": "asia-pacific"},{"address": "Boulevard Corporate Tower Av. dos Andradas, 3000 - Andares 14-17 Santa Efig\u00eania Belo Horizonte 30260-070, Brazil","id": "belo-horizonte","image": "https://lh3.googleusercontent.com/f7F8gTi9GSgAZR3lv24I1yb-D0wRlDy0lQTcxCB4yJGtSgxrWdKoB3dX3J8SMrjYLwOSXquO3LuGFUE82QUjzVK9buHGNIRUPGpqM3E","lat": -19.920225,"lng": -43.920845,"name": "Belo Horizonte","phone": "+55-31-2128-6800","region": "latin-america"}]}';
    final jsonResponse = json.decode(listData);
    getLatLong location = new getLatLong.fromJson(jsonResponse);
    return location.getlist;
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'image/ic_marker.png');
  }

  void setCustomMapPin1() async {
    pinLocationIcon1 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'image/ic_green_marker.png');
  }

  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print('LatLong ::::$_currentPosition');
        _lng = LatLng(_currentPosition.latitude, _currentPosition.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: spacikoColor.Colorwhite,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[

          /*top layout*/
          Container(
            padding: EdgeInsets.only(bottom: 10),
            color: spacikoColor.Colorwhite,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                /*search edittext*/
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          child: TextField(
                            cursorColor: Colors.grey,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'poppins_regular',
                                color: Colors.grey),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 30,
                              ),
                              hintText: "Address, city, zip, Neighborhood",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins_regular',
                                  color: Colors.grey
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 25, top: 25),
                        alignment: Alignment.centerRight,
                        child: Image(
                          image: AssetImage('image/ic_green_send.png'),
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ],
                  ),
                ),

                /*for select Time period*/
                Container(
                  margin: EdgeInsets.only(top: 5, left: 6, right: 10),
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _list[index].selected = !_list[index].selected;

                            if (index == 3) {
                              if (_list[index].selected) {
                                isVisible = true;
                              } else {
                                isVisible = false;
                              }
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: 8,
                          ),
                          width: MediaQuery.of(context).size.width / 4,

                          child: Text(_list[index].title,
                              style: TextStyle(
                                fontFamily: 'poppins_regular',
                                fontSize: 13,
                                color: _list[index].selected
                                    ? spacikoColor.Colorwhite
                                    : spacikoColor.ColorPrimary,
                              )),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: spacikoColor.ColorPrimary),

                            color: _list[index].selected
                                ? spacikoColor.ColorPrimary
                                : spacikoColor.Colorwhite,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),



          /*bottom layout*/
          Flexible(
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: spacikoColor.Colorwhite,

                  child: _lng != null
                      ? GoogleMap(

                    initialCameraPosition: CameraPosition(target: _lng, zoom: 8),
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);

                      setState(() {
                        print('set 1::::$isScrollVisible');

                        for(int i=0; i<list.length; i++){
                          _markers.add(Marker(markerId: MarkerId(list[i].id),
                              //icon: pinLocationIcon, position: LatLng(list[i].lat, list[i].lng), infoWindow: InfoWindow(title: list[i].id),
                              icon: isScrollVisible == true? pinLocationIcon1 : pinLocationIcon, position: LatLng(list[i].lat, list[i].lng), infoWindow: InfoWindow(title: list[i].id),

                              /*marker click*/
                              onTap: ()  {
                                  setState(() {
                                    print('SET::::');
                                    _markers.add(Marker(markerId: MarkerId(list[i].id),
                                    icon: pinLocationIcon1, position: LatLng(list[i].lat, list[i].lng),
                                        infoWindow: InfoWindow(title: list[i].id)));

                                    isScrollVisible = true;

                                      _index = i;
                                      _pageController = new PageController(initialPage: _index,viewportFraction: 0.75, keepPage: true);

                                    Future.delayed(Duration(milliseconds: 30), () {
                                      print('called:::::');
                                      _pageController.animateToPage(_index, curve: Curves.easeInOutSine, duration: Duration(milliseconds: 300));
                                      _pageController?.jumpToPage(_index);
                                    });
                                  });
                              })
                          );
                        }
                      });
                    },

                    /*outside click*/
                    onTap: (LatLng latLng){
                      setState(() {
                        isScrollVisible = false;
                      });
                    },
                  )
                      : Center(
                    child: CircularProgressIndicator(),
                  ),
                ),


                /*bottom scroll view*/
                Visibility(
                  visible: isScrollVisible,

                  child:  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.bottomCenter,

                    child: SizedBox(
                      height: 210,
                      width: MediaQuery.of(context).size.width,

                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: AlwaysScrollableScrollPhysics(),

                        onPageChanged: (int index) =>
                            setState(() =>
                            _index = index),

                        controller: _pageController,
                        itemCount: list.length,

                        itemBuilder: (context, i) {
                          print('SCROLL:::::${_index}');

                          return Transform.scale(
                            scale: i == _index ? 1.03 : 0.9,

                            /*white box desing*/
                            child: GestureDetector(
                              onTap: () {
                              },

                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                elevation: 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[

                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 113,

                                          child: Image.network(
                                            list[i].image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      /*name*/
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(left: 10, top: 2),
                                        child: Text(list[i].name, style: TextStyle(fontSize: 16, fontFamily: 'poppins_semibold',
                                            color: spacikoColor.Colorblack),
                                        ),
                                      ),

                                      /*work*/
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(left: 10, top: 5),
                                        child: Text(list[i].region, style: TextStyle(fontSize: 12, fontFamily: 'poppins_regular',
                                            color: spacikoColor.Colorlightblack),
                                        ),
                                      ),

                                      /*address*/
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(left: 10,),
                                        child: Text(
                                          list[i].address,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'poppins_regular',
                                              color:
                                              spacikoColor.Colorlightblack),
                                        ),
                                      ),

                                      /*rupees*/
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(left: 10,),
                                        child: Text('Lat : ${list[i].lat}   Lng : ${list[i].lng}', style: TextStyle(fontSize: 12, fontFamily: 'poppins_regular',
                                            color: spacikoColor.Colorlightblack),
                                        ),
                                      ),

                                      /*green line*/
                                      Container(
                                        margin: EdgeInsets.only(top: 2, left: 3, right: 3),
                                        height: 2,
                                        width: MediaQuery.of(context).size.width,
                                        color: spacikoColor.ColorPrimary,
                                      )
                                    ],
                                  ),
                              ),
                            ),
                          );
                        },

                      ),
                    ),
                  ),
                ),



                /*open dialog*/
                Visibility(
                  visible: isVisible,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width,
                      color: spacikoColor.Colorwhite,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          /*top count text*/
                          Container(
                            color: spacikoColor.Colorwhite,
                            padding: EdgeInsets.only(left: 15),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Property Type (${_propertyList.where((element) => element.isChecked).toList().length} Selected)',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'poppins_regular',
                                  color: spacikoColor.Colorblack),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          /*grid view*/
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            // height: 150,
                            color: spacikoColor.Colorwhite,
                            child: GridView.count(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              childAspectRatio: 5.1,
                              crossAxisCount: 2,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              children:
                                  List.generate(_propertyList.length, (index) {
                                return GridTile(
                                    child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(width: 10),
                                      _propertyList[index].isChecked ? Icon(Icons.check_circle, color: spacikoColor.ColorPrimary, size: 25,)
                                          : Icon(Icons.circle, color: Colors.grey[300], size: 25,),

                                      SizedBox(width: 8),
                                      Text(_propertyList[index].propertyName,
                                        style: TextStyle(fontSize: 14, fontFamily: 'poppins_regular', color: spacikoColor.Colorlightblack),
                                      ),
                                    ],
                                  ),

                                  onTap: () {
                                    setState(() {
                                      _propertyList[index].isChecked = !_propertyList[index].isChecked;
                                      print(_propertyList[index].isChecked);
                                      print(_propertyList.where((element) => element.isChecked).toList().length);
                                    });
                                  },
                                ));
                              }),
                            ),
                          ),

                          /*reset or Done*/
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 15),
                            height: 60,
                            color: spacikoColor.ColorPrimary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                /*Reset Text*/
                                Container(
                                  child: InkWell(
                                    child: Text('Reset',
                                      style: TextStyle(
                                          fontFamily: 'poppins_medium',
                                          fontSize: 20,
                                          color: spacikoColor.Colorwhite),
                                    ),


                                    onTap: () {
                                      setState(() {
                                        for (int i = 0; i < _propertyList.length; i++) {
                                          _propertyList[i].isChecked = false;
                                        }
                                      });
                                    },
                                  ),
                                ),


                                /*done button*/
                                Container(
                                  child: RaisedButton(
                                    elevation: 2,
                                    color: spacikoColor.Colorwhite,
                                    child: Text(
                                      "done".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "poppins_regular",
                                          color: spacikoColor.ColorPrimary),
                                    ),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),

                                    onPressed: () {
                                      setState(() {
                                        isVisible = false;
                                        _list[3].selected = false;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}


/*priority Model*/
class Choice {
  String title;
  bool selected = false;

  Choice({this.title});
}

/*property model*/
class SelectProperty {
  String propertyName;
  bool isChecked = false;

  SelectProperty({this.propertyName});
}
